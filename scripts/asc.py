"""App Store Connect API helper.

Reads the Apple ASC API key from ~/.appstoreconnect/private_keys/AuthKey_<ID>.p8
and the issuer ID from $APP_STORE_CONNECT_ISSUER_ID.

Subcommands:
    list-apps                        Shows all apps in the team.
    get-app <bundle-id>              Lookup app by bundle id.
    create-app <bundle-id> <name>    Create app (requires team SKU + lang).
    list-iaps <app-id>               List in-app purchases / subscriptions.
    list-builds <app-id>             List uploaded builds (TestFlight pipeline).

Returns JSON to stdout.
"""

from __future__ import annotations

import json
import os
import sys
import time
from pathlib import Path

import jwt
import requests

ASC_BASE = "https://api.appstoreconnect.apple.com/v1"
KEY_DIR = Path.home() / ".appstoreconnect" / "private_keys"


def find_key() -> tuple[str, Path]:
    """Return (key_id, p8_path) for the first AuthKey file."""
    keys = sorted(KEY_DIR.glob("AuthKey_*.p8"))
    if not keys:
        raise SystemExit(f"No ASC keys found in {KEY_DIR}")
    p = keys[0]
    key_id = p.stem.replace("AuthKey_", "")
    return key_id, p


def make_token(issuer_id: str, key_id: str, p8_path: Path) -> str:
    private_key = p8_path.read_text()
    now = int(time.time())
    payload = {
        "iss": issuer_id,
        "iat": now,
        "exp": now + 60 * 19,
        "aud": "appstoreconnect-v1",
    }
    return jwt.encode(
        payload,
        private_key,
        algorithm="ES256",
        headers={"kid": key_id, "typ": "JWT"},
    )


def http(method: str, path: str, token: str, **kw) -> requests.Response:
    url = path if path.startswith("http") else f"{ASC_BASE}{path}"
    headers = kw.pop("headers", {})
    headers["Authorization"] = f"Bearer {token}"
    return requests.request(method, url, headers=headers, timeout=30, **kw)


def cmd_list_apps(token: str) -> None:
    r = http("GET", "/apps?limit=200&fields[apps]=bundleId,name,sku", token)
    r.raise_for_status()
    data = r.json()
    out = [
        {
            "id": a["id"],
            "bundleId": a["attributes"]["bundleId"],
            "name": a["attributes"]["name"],
            "sku": a["attributes"].get("sku"),
        }
        for a in data.get("data", [])
    ]
    print(json.dumps(out, indent=2, ensure_ascii=False))


def cmd_get_app(token: str, bundle_id: str) -> None:
    r = http(
        "GET",
        f"/apps?filter[bundleId]={bundle_id}&fields[apps]=bundleId,name,sku",
        token,
    )
    r.raise_for_status()
    data = r.json().get("data", [])
    if not data:
        print(json.dumps({"found": False, "bundleId": bundle_id}))
        return
    a = data[0]
    print(json.dumps(
        {
            "found": True,
            "id": a["id"],
            "bundleId": a["attributes"]["bundleId"],
            "name": a["attributes"]["name"],
            "sku": a["attributes"].get("sku"),
        },
        indent=2,
        ensure_ascii=False,
    ))


def cmd_create_app(token: str, bundle_id: str, name: str) -> None:
    bundle_r = http(
        "GET",
        f"/bundleIds?filter[identifier]={bundle_id}",
        token,
    )
    bundle_r.raise_for_status()
    bundle_data = bundle_r.json().get("data", [])
    if not bundle_data:
        print(json.dumps({"error": f"Bundle ID {bundle_id} not registered"}))
        sys.exit(1)
    bundle_pk = bundle_data[0]["id"]

    body = {
        "data": {
            "type": "apps",
            "attributes": {
                "bundleId": bundle_id,
                "name": name,
                "primaryLocale": "tr",
                "sku": bundle_id.replace(".", "-"),
            },
            "relationships": {
                "bundleId": {
                    "data": {"type": "bundleIds", "id": bundle_pk}
                }
            },
        }
    }
    r = http(
        "POST",
        "/apps",
        token,
        json=body,
        headers={"Content-Type": "application/json"},
    )
    if r.status_code >= 400:
        print(json.dumps({"error": r.status_code, "body": r.json()}, indent=2))
        sys.exit(1)
    print(json.dumps(r.json(), indent=2, ensure_ascii=False))


def cmd_list_iaps(token: str, app_id: str) -> None:
    r = http(
        "GET",
        f"/apps/{app_id}/inAppPurchasesV2?limit=200",
        token,
    )
    r.raise_for_status()
    print(json.dumps(r.json(), indent=2, ensure_ascii=False))


def cmd_list_builds(token: str, app_id: str) -> None:
    r = http(
        "GET",
        f"/builds?filter[app]={app_id}&limit=20&sort=-uploadedDate",
        token,
    )
    r.raise_for_status()
    data = r.json().get("data", [])
    out = [
        {
            "id": b["id"],
            "version": b["attributes"]["version"],
            "uploadedDate": b["attributes"].get("uploadedDate"),
            "processingState": b["attributes"].get("processingState"),
        }
        for b in data
    ]
    print(json.dumps(out, indent=2, ensure_ascii=False))


def main() -> None:
    if len(sys.argv) < 2:
        print(__doc__, file=sys.stderr)
        sys.exit(2)
    issuer = os.environ.get("APP_STORE_CONNECT_ISSUER_ID")
    if not issuer:
        print(
            "Set APP_STORE_CONNECT_ISSUER_ID env var. "
            "Find it at: https://appstoreconnect.apple.com/access/integrations/api",
            file=sys.stderr,
        )
        sys.exit(2)
    key_id, p8 = find_key()
    token = make_token(issuer, key_id, p8)

    cmd, *rest = sys.argv[1:]
    try:
        if cmd == "list-apps":
            cmd_list_apps(token)
        elif cmd == "get-app":
            cmd_get_app(token, rest[0])
        elif cmd == "create-app":
            cmd_create_app(token, rest[0], rest[1])
        elif cmd == "list-iaps":
            cmd_list_iaps(token, rest[0])
        elif cmd == "list-builds":
            cmd_list_builds(token, rest[0])
        else:
            print(f"Unknown command: {cmd}", file=sys.stderr)
            sys.exit(2)
    except requests.HTTPError as e:
        print(
            json.dumps(
                {"http_error": e.response.status_code, "body": e.response.text},
                indent=2,
                ensure_ascii=False,
            ),
            file=sys.stderr,
        )
        sys.exit(1)


if __name__ == "__main__":
    main()
