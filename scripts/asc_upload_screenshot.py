"""Upload a review screenshot to an ASC subscription.

Usage: python asc_upload_screenshot.py <subscription_id> <png_path>

Flow per Apple docs:
1. POST /v1/subscriptionAppStoreReviewScreenshots — reserve, get uploadOperations
2. PUT each chunk to its uploadOperations URL
3. PATCH .../{id} with uploaded=true + sourceFileChecksum (md5)
"""

from __future__ import annotations

import hashlib
import os
import sys
from pathlib import Path

import requests

sys.path.insert(0, str(Path(__file__).parent))
from asc import find_key, http, make_token


def upload(subscription_id: str, png: Path, token: str) -> None:
    size = png.stat().st_size
    body = {
        "data": {
            "type": "subscriptionAppStoreReviewScreenshots",
            "attributes": {"fileSize": size, "fileName": png.name},
            "relationships": {
                "subscription": {
                    "data": {"type": "subscriptions", "id": subscription_id}
                }
            },
        }
    }
    r = http(
        "POST",
        "/subscriptionAppStoreReviewScreenshots",
        token,
        json=body,
        headers={"Content-Type": "application/json"},
    )
    if r.status_code >= 400:
        print(f"reserve failed {r.status_code}: {r.text}")
        sys.exit(1)
    j = r.json()
    asset_id = j["data"]["id"]
    ops = j["data"]["attributes"]["uploadOperations"]
    print(f"reserved id={asset_id} ops={len(ops)}")

    md5 = hashlib.md5()
    data = png.read_bytes()
    md5.update(data)
    checksum = md5.hexdigest()

    for op in ops:
        method = op["method"]
        url = op["url"]
        offset = op["offset"]
        length = op["length"]
        chunk = data[offset : offset + length]
        headers = {h["name"]: h["value"] for h in op["requestHeaders"]}
        r = requests.request(method, url, data=chunk, headers=headers, timeout=120)
        if r.status_code >= 400:
            print(f"chunk upload failed {r.status_code}: {r.text}")
            sys.exit(1)
        print(f"  uploaded chunk offset={offset} len={length}")

    body = {
        "data": {
            "type": "subscriptionAppStoreReviewScreenshots",
            "id": asset_id,
            "attributes": {"uploaded": True, "sourceFileChecksum": checksum},
        }
    }
    r = http(
        "PATCH",
        f"/subscriptionAppStoreReviewScreenshots/{asset_id}",
        token,
        json=body,
        headers={"Content-Type": "application/json"},
    )
    if r.status_code >= 400:
        print(f"commit failed {r.status_code}: {r.text}")
        sys.exit(1)
    print(f"committed {asset_id}")


def main() -> None:
    if len(sys.argv) != 3:
        print(__doc__, file=sys.stderr)
        sys.exit(2)
    issuer = os.environ["APP_STORE_CONNECT_ISSUER_ID"]
    kid, p8 = find_key()
    token = make_token(issuer, kid, p8)
    upload(sys.argv[1], Path(sys.argv[2]), token)


if __name__ == "__main__":
    main()
