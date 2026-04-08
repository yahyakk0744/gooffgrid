// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'gooffgrid';

  @override
  String get appSlogan => 'Desconéctate. Juega. No te pierdas en lo digital.';

  @override
  String get home => 'Inicio';

  @override
  String get ranking => 'Clasificación';

  @override
  String get duel => 'Duelo';

  @override
  String get profile => 'Perfil';

  @override
  String get settings => 'Ajustes';

  @override
  String get stories => 'Historias';

  @override
  String get today => 'Hoy';

  @override
  String get thisWeek => 'Esta semana';

  @override
  String get friends => 'Amigos';

  @override
  String get friendsOf => 'Amigos de';

  @override
  String get allFriends => 'Todos';

  @override
  String get city => 'Ciudad';

  @override
  String get country => 'País';

  @override
  String get global => 'Global';

  @override
  String minutes(int count) {
    return '$count min';
  }

  @override
  String hours(int count) {
    return '$count h';
  }

  @override
  String hoursMinutes(int h, int m) {
    return '${h}h ${m}m';
  }

  @override
  String get screenTime => 'Tiempo de pantalla';

  @override
  String get phonePickups => 'Veces que cogiste el móvil';

  @override
  String pickupsToday(int count) {
    return 'Cogiste el móvil $count veces hoy';
  }

  @override
  String get topTriggers => 'Principales desencadenantes';

  @override
  String get longestOffScreen => 'Mayor tiempo sin pantalla';

  @override
  String get dailyGoal => 'Meta diaria';

  @override
  String goalHours(int count) {
    return 'Meta: $count horas';
  }

  @override
  String get streak => 'Racha';

  @override
  String streakDays(int count) {
    return '$count días';
  }

  @override
  String get level => 'Nivel';

  @override
  String get badges => 'Insignias';

  @override
  String get duels => 'Duelos';

  @override
  String get activeDuels => 'Activos';

  @override
  String get pastDuels => 'Pasados';

  @override
  String get createDuel => 'Crear duelo';

  @override
  String get startDuel => 'Iniciar duelo';

  @override
  String get invite => 'Invitar';

  @override
  String get accept => 'Aceptar';

  @override
  String get decline => 'Rechazar';

  @override
  String get win => 'Ganado';

  @override
  String get lose => 'Perdido';

  @override
  String get draw => 'Empate';

  @override
  String get addFriend => 'Agregar amigo';

  @override
  String get friendCode => 'Código de amigo';

  @override
  String get search => 'Buscar';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get dailyReminder => 'Recordatorio diario';

  @override
  String get duelNotifications => 'Notificaciones de duelo';

  @override
  String get locationSharing => 'Compartir ubicación';

  @override
  String get subscription => 'Suscripción';

  @override
  String get free => 'Gratis';

  @override
  String get pro => 'Pro';

  @override
  String get proPlus => 'Pro+';

  @override
  String get currentPlan => 'Plan actual';

  @override
  String get recommended => 'Recomendado';

  @override
  String get start => 'Comenzar';

  @override
  String get upgradeToPro => 'Actualizar a Pro';

  @override
  String get upgradeToProPlus => 'Actualizar a Pro+';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String monthlyPrice(String price) {
    return '$price/mes';
  }

  @override
  String get freeFeature1 => 'Seguimiento diario del tiempo de pantalla';

  @override
  String get freeFeature2 => 'Clasificaciones de amigos';

  @override
  String get freeFeature3 => '3 duelos activos';

  @override
  String get freeFeature4 => 'Insignias básicas';

  @override
  String get proFeature1 => 'Todas las clasificaciones (ciudad, país, global)';

  @override
  String get proFeature2 => 'Estadísticas detalladas y calendario de enfoque';

  @override
  String get proFeature3 => 'Duelos ilimitados';

  @override
  String get proFeature4 => 'Pases Off-Grid incluidos';

  @override
  String get proFeature5 => 'Experiencia sin anuncios';

  @override
  String get proPlusFeature1 => 'Todo lo de Pro';

  @override
  String get proPlusFeature2 => 'Plan familiar (5 personas)';

  @override
  String get proPlusFeature3 => 'Soporte prioritario';

  @override
  String get proPlusFeature4 => 'Insignias y temas exclusivos';

  @override
  String get proPlusFeature5 => 'Acceso anticipado a funciones beta';

  @override
  String get paywallTitle => 'Club Off-Grid';

  @override
  String get paywallSubtitle => 'Sé recompensado por desconectarte.';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get shareProfile => 'Compartir perfil';

  @override
  String get shareReportCard => 'Presume tu récord';

  @override
  String get appUsage => 'Uso de aplicaciones';

  @override
  String get whatDidYouUse => '¿Qué usaste hoy?';

  @override
  String get weeklyReport => 'Informe semanal';

  @override
  String get weeklyTrend => 'Tendencia de 7 días';

  @override
  String get seasons => 'Temporadas';

  @override
  String get seasonPass => 'Pases Off-Grid';

  @override
  String get groups => 'Grupos';

  @override
  String get createGroup => 'Crear grupo';

  @override
  String get stats => 'Estadísticas';

  @override
  String get analytics => 'Analítica';

  @override
  String get detailedAnalytics => 'Analítica detallada';

  @override
  String get categories => 'Categorías';

  @override
  String get weeklyUsage => 'Uso semanal';

  @override
  String get appDetails => 'Detalles de la app';

  @override
  String get focusCalendar => 'Calendario de enfoque';

  @override
  String get whatIf => '¿Y si?';

  @override
  String get focusMode => 'Respirar';

  @override
  String get startFocusMode => 'Iniciar modo enfoque';

  @override
  String get focusing => 'Estás enfocado...';

  @override
  String focusComplete(int minutes) {
    return '¡Genial! Te enfocaste durante $minutes min';
  }

  @override
  String get focusTimeout => 'Tiempo de sesión agotado';

  @override
  String get focusTimeoutDesc =>
      'Has alcanzado el límite de 120 minutos.\n¿Sigues ahí?';

  @override
  String get end => 'Terminar';

  @override
  String get reportCard => 'Boletín';

  @override
  String get antiSocialStory => 'Momento anti-social';

  @override
  String get storyQuestion => '¿Qué estás haciendo lejos de tu teléfono?';

  @override
  String get postStory => 'Publicar';

  @override
  String get storyExpired => 'Expirada';

  @override
  String get noStories => 'Todavía no hay historias';

  @override
  String get noStoriesHint =>
      '¡Que tus amigos empiecen a compartir sus momentos off-grid!';

  @override
  String get storyBlocked => 'No puedes compartir una historia';

  @override
  String get storyBlockedHint =>
      'Has superado tu meta diaria de tiempo de pantalla. ¡Cumple tu meta para ganar el derecho a compartir historias!';

  @override
  String get duration => 'Duración';

  @override
  String get walk => 'Caminar';

  @override
  String get run => 'Correr';

  @override
  String get book => 'Libro';

  @override
  String get meditation => 'Meditación';

  @override
  String get nature => 'Naturaleza';

  @override
  String get sports => 'Deportes';

  @override
  String get music => 'Música';

  @override
  String get cooking => 'Cocinar';

  @override
  String get friendsActivity => 'Amigos';

  @override
  String get family => 'Familia';

  @override
  String get o2Balance => 'Puntos O₂';

  @override
  String o2Remaining(int count) {
    return 'Restante: $count';
  }

  @override
  String o2Today(int earned, int max) {
    return 'Hoy: $earned/$max O₂';
  }

  @override
  String get o2Rules => 'Reglas O₂';

  @override
  String get o2RuleTime => 'Solo se gana entre las 08:00 y las 00:00';

  @override
  String get o2RuleDaily => 'Máx. 500 O₂ por día';

  @override
  String get o2RuleFocus => 'Modo enfoque máx. 120 min';

  @override
  String get o2RuleTransfer => 'Sin transferencias ni apuestas';

  @override
  String o2Estimated(int amount) {
    return '+$amount O₂ (estimado)';
  }

  @override
  String get offGridMarket => 'Botín';

  @override
  String get offGridMarketHint =>
      'Convierte tus puntos O₂ en recompensas reales';

  @override
  String get redeem => 'Canjear';

  @override
  String get insufficient => 'Insuficiente';

  @override
  String get redeemSuccess => '¡Felicidades!';

  @override
  String get couponCode => 'Tu código de cupón:';

  @override
  String get recentTransactions => 'Transacciones recientes';

  @override
  String get noTransactions => 'Aún no hay transacciones';

  @override
  String get categorySocial => 'Social';

  @override
  String get categoryGame => 'Juegos';

  @override
  String get categoryVideo => 'Vídeo';

  @override
  String get categoryAudio => 'Música';

  @override
  String get categoryProductivity => 'Productividad';

  @override
  String get categoryNews => 'Noticias';

  @override
  String get categoryGames => 'Juegos';

  @override
  String get categoryShopping => 'Compras';

  @override
  String get categoryBrowser => 'Navegador';

  @override
  String get categoryMaps => 'Mapas';

  @override
  String get categoryImage => 'Fotos';

  @override
  String get categoryOther => 'Otros';

  @override
  String hello(String name) {
    return 'Hola, $name';
  }

  @override
  String get goalCompleted => '¡Meta completada!';

  @override
  String get dailyGoalShort => 'Meta diaria';

  @override
  String get streakDaysLabel => 'días seguidos';

  @override
  String get o2Label => 'O₂';

  @override
  String get rankLabel => 'rango';

  @override
  String get offlineLabel => 'sin conexión';

  @override
  String get todaysApps => 'Apps de hoy';

  @override
  String get seeAll => 'Ver todo';

  @override
  String get activeDuel => 'Duelo activo';

  @override
  String get startDuelPrompt => '¡Empieza un duelo!';

  @override
  String get you => 'Tú';

  @override
  String moreCount(int count) {
    return '+$count más';
  }

  @override
  String get removeWithPro => 'Quitar con Pro';

  @override
  String get adLabel => 'Anuncio';

  @override
  String get focus => 'Enfoque';

  @override
  String get legal => 'Legal';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get termsOfService => 'Términos de servicio';

  @override
  String get kvkkText => 'Aviso de privacidad RGPD';

  @override
  String get deleteMyAccount => 'Eliminar mi cuenta';

  @override
  String get edit => 'Editar';

  @override
  String get adminAddLoot => 'Admin: Agregar botín';

  @override
  String get continueConsent => 'Al continuar';

  @override
  String get acceptTermsSuffix => 'aceptas.';

  @override
  String get alreadyHaveAccount => 'Ya tengo una cuenta';

  @override
  String get screenTimePermissionTitle =>
      'Necesitamos rastrear tu tiempo de pantalla';

  @override
  String get screenTimePermissionDesc =>
      'Se requiere acceso al tiempo de pantalla para ver cuánto tiempo pasas en cada app.';

  @override
  String get screenTimeGranted => '¡Permiso de tiempo de pantalla concedido!';

  @override
  String get continueButton => 'Continuar';

  @override
  String get skip => 'Omitir';

  @override
  String get yourName => 'Tu nombre';

  @override
  String get nameHint => 'Ingresa tu nombre';

  @override
  String get ageGroup => 'Grupo de edad';

  @override
  String get imReady => 'Estoy listo';

  @override
  String get dailyGoalTitle => 'Tu meta diaria';

  @override
  String get goalQuestion =>
      '¿Cuántas horas de tiempo de pantalla te propones al día?';

  @override
  String get goalMotivational1 =>
      '¡Increíble! Una verdadera meta de desintoxicación digital 💪';

  @override
  String get goalMotivational2 => 'Una meta equilibrada, ¡puedes lograrlo! 🎯';

  @override
  String get goalMotivational3 =>
      'Un buen comienzo, puedes reducir con el tiempo 📉';

  @override
  String get goalMotivational4 => 'Paso a paso, cada minuto cuenta ⭐';

  @override
  String get next => 'Siguiente';

  @override
  String hourShort(int count) {
    return '${count}h';
  }

  @override
  String get welcomeSlogan =>
      'Deja el teléfono. Supera a tus amigos.\nSé el #1 en tu ciudad.';

  @override
  String get deleteAccount => 'Eliminar cuenta';

  @override
  String get deleteAccountConfirm =>
      'Tu cuenta y todos los datos serán eliminados permanentemente. Esta acción no se puede deshacer.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get ok => 'OK';

  @override
  String get error => 'Error';

  @override
  String get tryAgain => 'Intentar de nuevo';

  @override
  String get loading => 'Cargando...';

  @override
  String get loadFailed => 'Error al cargar';

  @override
  String get noDataYet => 'Aún no hay datos';

  @override
  String get welcome => 'Bienvenido';

  @override
  String get welcomeSubtitle => 'Deja el teléfono. Supera a tus amigos.';

  @override
  String get continueWithGoogle => 'Continuar con Google';

  @override
  String get continueWithApple => 'Continuar con Apple';

  @override
  String get continueWithEmail => 'Continuar con correo electrónico';

  @override
  String get permissionsTitle => 'Permisos';

  @override
  String get permissionsSubtitle =>
      'Necesitamos permiso para rastrear tu tiempo de pantalla.';

  @override
  String get grantPermission => 'Conceder permiso';

  @override
  String get setupProfile => 'Configurar perfil';

  @override
  String get displayName => 'Nombre visible';

  @override
  String get selectCity => 'Seleccionar ciudad';

  @override
  String get selectGoal => 'Seleccionar meta diaria';

  @override
  String get noDuelsYet => 'Aún no hay duelos';

  @override
  String get noDuelsYetSubtitle => '¡Empieza tu primer duelo!';

  @override
  String get activeDuelsTitle => 'Duelos activos';

  @override
  String get newDuel => 'Nuevo duelo';

  @override
  String get selectDuelType => 'Seleccionar tipo de duelo';

  @override
  String get selectDurationStep => 'Seleccionar duración';

  @override
  String get selectOpponent => 'Seleccionar oponente';

  @override
  String get duelStartButton => '¡Iniciar duelo! ⚔️';

  @override
  String get freePlanDuelLimit =>
      '¡El plan gratuito permite máx. 3 duelos activos! Actualiza a Pro.';

  @override
  String get quickSelect => 'Selección rápida';

  @override
  String get customDuration => 'Duración personalizada';

  @override
  String selectedDuration(String duration) {
    return 'Seleccionado: $duration';
  }

  @override
  String get minDurationWarning => 'Debes seleccionar al menos 10 minutos';

  @override
  String get selectPenalty => 'Seleccionar penalización (opcional)';

  @override
  String get searchFriend => 'Buscar amigo...';

  @override
  String get inviteWithLink => 'Invitar con enlace 🔗';

  @override
  String todayMinutesLabel(int count) {
    return '${count}min hoy';
  }

  @override
  String duelRemaining(int h, int m) {
    return 'Quedan ${h}h ${m}m';
  }

  @override
  String get remainingTime => 'Tiempo restante';

  @override
  String watchersCount(int count) {
    return '$count mirando 👀';
  }

  @override
  String get giveUp => 'Rendirse';

  @override
  String get duelWon => '¡Ganaste! 🎉';

  @override
  String get duelLost => 'Perdiste 😔';

  @override
  String get greatPerformance => '¡Gran actuación!';

  @override
  String get betterNextTime => '¡La próxima vez será mejor!';

  @override
  String get revenge => 'Tomar revancha 🔥';

  @override
  String get share => 'Compartir';

  @override
  String get selectFriend => 'Seleccionar amigo';

  @override
  String get orSendLink => 'o enviar enlace';

  @override
  String get social => 'Social';

  @override
  String get myFriends => 'Mis amigos';

  @override
  String get inMyCity => 'En mi ciudad';

  @override
  String get shareFirstStory =>
      '¡Sé el primero en compartir tu momento off-grid!';

  @override
  String get createStoryTitle => 'Compartir historia';

  @override
  String get addPhoto => 'Agregar foto';

  @override
  String get whatAreYouDoing => '¿Qué estás haciendo?';

  @override
  String get captionHint => '¿Qué estás haciendo lejos de tu teléfono?';

  @override
  String get howLongVisible => '¿Cuánto tiempo debe ser visible?';

  @override
  String get whoCanSee => '¿Quién puede verla?';

  @override
  String get onlyFriends => 'Solo mis amigos';

  @override
  String get cityPeople => 'Personas de mi ciudad';

  @override
  String get photoStoriesPro =>
      '¡Las historias con foto son Pro! Ajustes > Club Off-Grid';

  @override
  String get camera => 'Cámara';

  @override
  String get gallery => 'Galería';

  @override
  String get writeFirst => '¡Escribe algo primero!';

  @override
  String get inappropriateContent => 'Contenido inapropiado detectado';

  @override
  String viewsCount(int count) {
    return '$count vistas';
  }

  @override
  String get editProfile => 'Editar perfil';

  @override
  String get changePhoto => 'Cambiar foto';

  @override
  String get firstName => 'Nombre';

  @override
  String get firstNameHint => 'Tu nombre';

  @override
  String get lastName => 'Apellido';

  @override
  String get lastNameHint => 'Tu apellido';

  @override
  String get usernameLabel => 'Nombre de usuario';

  @override
  String get updateLocation => 'Actualizar ubicación';

  @override
  String get locationUnknown => 'Desconocido';

  @override
  String get save => 'Guardar';

  @override
  String get usernameAvailable => 'Disponible';

  @override
  String get usernameTaken => 'Este nombre de usuario está en uso';

  @override
  String get usernameFormatError =>
      'Al menos 3 caracteres, solo letras, números y _';

  @override
  String get profileUpdated => 'Perfil actualizado';

  @override
  String get photoSelectedDemo =>
      'Foto seleccionada (no se subirá en modo demo)';

  @override
  String get locationError => 'No se pudo obtener la ubicación';

  @override
  String get errorOccurred => 'Ocurrió un error';

  @override
  String get detailedScreenTime => 'Tiempo de pantalla detallado';

  @override
  String get monthlyTop10 => 'Top 10 mensual';

  @override
  String get searchHint => 'Buscar...';

  @override
  String get noFriendsYet => 'Aún no tienes amigos';

  @override
  String get noFriendsHint => 'Empieza agregando un amigo';

  @override
  String get showQrCode => 'Muestra tu código QR';

  @override
  String get enterCode => 'Ingresar código';

  @override
  String get inviteLinkShare => 'Compartir enlace de invitación';

  @override
  String get startDuelAction => 'Iniciar duelo';

  @override
  String get pointsLabel => 'Puntos';

  @override
  String get mostUsedLabel => 'Más usado:';

  @override
  String get recentBadges => 'Insignias recientes';

  @override
  String get allBadgesLabel => 'Todas las insignias';

  @override
  String get removeFriend => 'Eliminar amigo';

  @override
  String get removeFriendConfirm =>
      '¿Seguro que quieres eliminar a esta persona de tu lista de amigos?';

  @override
  String get remove => 'Eliminar';

  @override
  String get requestSent => 'Solicitud enviada';

  @override
  String get whatCouldYouDo => '¿Qué podrías haber hecho?';

  @override
  String get back => 'Volver';

  @override
  String get weekly => 'Semanal';

  @override
  String get daily => 'Diario';

  @override
  String get mostUsedApps => 'Apps más usadas';

  @override
  String get unlockSection => 'Desbloqueos';

  @override
  String get selectedDayLabel => 'Día seleccionado';

  @override
  String get todayLabel => 'Hoy';

  @override
  String weeklyAvgLabel(int h, int m) {
    return 'Prom. diario: ${h}h ${m}m';
  }

  @override
  String get firstUnlock => 'Primer desbloqueo';

  @override
  String get mostOpened => 'Más abierto';

  @override
  String get timesPickedUp => 'Veces cogido';

  @override
  String get openingCount => 'aperturas';

  @override
  String get notificationUnit => 'notificaciones';

  @override
  String get timesUnit => 'veces';

  @override
  String get turkey => 'Türkiye';

  @override
  String get consecutiveDays => 'días seguidos';

  @override
  String bestStreakLabel(int days) {
    return 'Mejor: $days días';
  }

  @override
  String get seriFriends => 'Amigos';

  @override
  String get oxygenTitle => 'Oxígeno (O₂)';

  @override
  String get totalO2 => 'Total';

  @override
  String get remainingShort => 'Restante';

  @override
  String get noOffersYet => 'Aún no hay ofertas';

  @override
  String o2SpentMsg(int amount) {
    return '$amount O₂ gastados';
  }

  @override
  String get mapLoadFailed => 'Error al cargar el mapa';

  @override
  String confirmRedeemMsg(String reward) {
    return '¿Quieres canjear $reward?';
  }

  @override
  String itemReceived(String item) {
    return '¡$item canjeado!';
  }

  @override
  String get insufficientO2 => 'O₂ insuficiente';

  @override
  String get season1Title => 'Temporada 1';

  @override
  String get season1Subtitle => 'Despertar primaveral';

  @override
  String get seasonPassBtn => 'Pase de temporada (99TL)';

  @override
  String get seasonPassLabel => 'Pase de temporada';

  @override
  String get noGroupsYet => 'Aún no hay grupos';

  @override
  String get noGroupsSubtitle => 'Crea un grupo con tus amigos';

  @override
  String get newGroup => 'Nuevo grupo';

  @override
  String memberCount(int count) {
    return '$count miembros';
  }

  @override
  String get weeklyGoal => 'Meta semanal';

  @override
  String challengeProgress(int percent) {
    return '$percent% completado';
  }

  @override
  String get membersLabel => 'Miembros';

  @override
  String get inviteLink => 'Enlace de invitación';

  @override
  String get linkCopied => '¡Enlace copiado!';

  @override
  String get copy => 'Copiar';

  @override
  String get qrCode => 'Código QR';

  @override
  String get groupNameLabel => 'Nombre del grupo';

  @override
  String get groupNameHint => 'Ingresa el nombre del grupo';

  @override
  String get groupNameEmpty => 'El nombre del grupo no puede estar vacío';

  @override
  String dailyGoalHours(int hours) {
    return 'Meta diaria: $hours horas';
  }

  @override
  String get addMember => 'Agregar miembro';

  @override
  String selectedCount(int count) {
    return '$count seleccionado(s)';
  }

  @override
  String get create => 'Crear';

  @override
  String groupCreated(String name) {
    return '¡$name creado!';
  }

  @override
  String invitedCount(int count) {
    return '$count personas invitadas';
  }

  @override
  String get screenTimeLower => 'tiempo de pantalla';

  @override
  String get improvedFromLastWeek => '12% mejor que la semana pasada';

  @override
  String get o2Earned => 'O₂ ganado';

  @override
  String get friendRank => 'Rango entre amigos';

  @override
  String cityRankLabel(String city) {
    return 'Rango en $city';
  }

  @override
  String get mostUsed => 'Más usado';

  @override
  String get offGridClub => 'Club Off-Grid';

  @override
  String get clubSubtitle =>
      'Logra el equilibrio digital y recibe recompensas.';

  @override
  String get planStarter => 'Inicial';

  @override
  String get planStarterSubtitle => 'Empieza con lo básico';

  @override
  String get currentPlanBtn => 'Plan actual';

  @override
  String get billingMonthly => 'Mensual';

  @override
  String get billingYearly => 'Anual';

  @override
  String get yearlySavings => '33% de descuento';

  @override
  String get planComparison => 'Comparación de planes';

  @override
  String get breathTechniquesComp => 'Técnicas de respiración';

  @override
  String get activeDuelsComp => 'Duelos activos';

  @override
  String get storyPhoto => 'Foto en historia';

  @override
  String get heatMap => 'Mapa de calor';

  @override
  String get top10Report => 'Informe Top 10';

  @override
  String get exclusiveBadges => 'Insignias exclusivas';

  @override
  String get adFree => 'Sin anuncios';

  @override
  String get familyPlanComp => 'Plan familiar';

  @override
  String get familyReport => 'Informe familiar';

  @override
  String get exclusiveThemes => 'Temas exclusivos';

  @override
  String get prioritySupport => 'Soporte prioritario';

  @override
  String get billingNote =>
      'La suscripción se puede cancelar en cualquier momento.\nPago procesado a través de App Store/Google Play.\nLa suscripción se renueva automáticamente.';

  @override
  String get restoreSuccess => '¡Compras restauradas!';

  @override
  String get restoreFailed => 'No se encontraron compras para restaurar.';

  @override
  String get packagesLoadFailed =>
      'Error al cargar los paquetes. Inténtalo de nuevo.';

  @override
  String get themesTitle => 'Temas';

  @override
  String get themeLockedMsg => '¡Este tema es Pro+! Ajustes > Club Off-Grid';

  @override
  String get familyPlanTitle => 'Plan familiar';

  @override
  String get familyPlanLocked => 'Equilibrio digital juntos';

  @override
  String get familyPlanLockedDesc =>
      'Agrega hasta 5 miembros de la familia, establezcan metas juntos y reciban informes familiares semanales.';

  @override
  String get weeklyFamilyReport => 'Informe familiar semanal';

  @override
  String get familyRanking => 'Clasificación familiar';

  @override
  String get totalOffline => 'Total sin conexión';

  @override
  String get average => 'Promedio';

  @override
  String get best => 'Mejor';

  @override
  String offlineTime(int h, int m) {
    return '${h}h ${m}m sin conexión';
  }

  @override
  String get enterName => 'Ingresar nombre';

  @override
  String get cannotUndo => '¡Esta acción no se puede deshacer!';

  @override
  String get deleteWarningDesc =>
      'Al eliminar tu cuenta, los siguientes datos se borrarán permanentemente:';

  @override
  String get deleteItem1 => 'Información del perfil y avatar';

  @override
  String get deleteItem2 => 'Todas las estadísticas de tiempo de pantalla';

  @override
  String get deleteItem3 => 'Lista de amigos y duelos';

  @override
  String get deleteItem4 => 'Historias y comentarios';

  @override
  String get deleteItem5 => 'Puntos O₂ y botín';

  @override
  String get deleteItem6 => 'Historial de suscripción';

  @override
  String get deleteSubscriptionNote =>
      'Si tienes una suscripción activa, primero debes cancelarla a través de Apple App Store o Google Play Store.';

  @override
  String get deleteConfirmCheck =>
      'Entiendo que mi cuenta y todos los datos serán eliminados permanentemente.';

  @override
  String get deleteAccountBtn => 'Eliminar mi cuenta permanentemente';

  @override
  String get deleteErrorMsg => 'Ocurrió un error. Inténtalo de nuevo.';

  @override
  String get emailHint => 'Correo electrónico';

  @override
  String get passwordHint => 'Contraseña';

  @override
  String get forgotPassword => 'Olvidé mi contraseña';

  @override
  String get passwordResetSent =>
      'Correo de restablecimiento de contraseña enviado.';

  @override
  String get signUp => 'Registrarse';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get orDivider => 'o';

  @override
  String get continueWithGoogleShort => 'Continuar con Google';

  @override
  String get continueWithAppleShort => 'Continuar con Apple';

  @override
  String get noAccountYet => '¿No tienes cuenta? ';

  @override
  String get adminExistingPoints => 'Puntos existentes';

  @override
  String get adminSearchPlace => 'Buscar lugar...';

  @override
  String get adminRewardTitle => 'Título de la recompensa (ej. Café gratis)';

  @override
  String get adminO2Cost => 'Costo O₂';

  @override
  String get adminSave => 'Guardar';

  @override
  String get adminSaved => '¡Guardado!';

  @override
  String get adminDeleteTitle => 'Eliminar';

  @override
  String get adminDeleteMsg => '¿Seguro que quieres eliminar este punto?';

  @override
  String adminDeleteError(String error) {
    return 'Error al eliminar: $error';
  }

  @override
  String get adminFillFields => 'Completa la recompensa y el costo O₂';

  @override
  String breathCount(int count) {
    return '$count respiraciones';
  }

  @override
  String minutesRemaining(int count) {
    return 'Quedan ${count}min';
  }

  @override
  String focusMinutes(int count) {
    return 'Te enfocaste durante $count minutos';
  }

  @override
  String get o2TimeRestriction => 'O₂ ganado solo entre 08:00 y 00:00';

  @override
  String get breathTechniqueProMsg =>
      '¡Esta técnica es Pro! Ajustes > Club Off-Grid';

  @override
  String get inhale => 'Inhalar';

  @override
  String get holdBreath => 'Retener';

  @override
  String get exhale => 'Exhalar';

  @override
  String get waitBreath => 'Esperar';

  @override
  String get proMostPopular => 'Más popular';

  @override
  String get proFamilyBadge => 'FAMILIA';

  @override
  String get comparedToLastWeek => 'comparado con la semana pasada';

  @override
  String get appBlockTitle => 'Bloqueo de apps';

  @override
  String get appBlockSchedule => 'Horario';

  @override
  String get appBlockEnableBlocking => 'Activar bloqueo';

  @override
  String get appBlockActive => 'El bloqueo está activado';

  @override
  String get appBlockInactive => 'El bloqueo está desactivado';

  @override
  String get appBlockStrictMode => 'Modo estricto';

  @override
  String get appBlockStrictDesc =>
      'No se puede desactivar hasta que termine el temporizador';

  @override
  String get appBlockStrictExpired => 'Temporizador expirado';

  @override
  String get appBlockStrictDurationTitle => 'Duración del modo estricto';

  @override
  String get appBlockDuration30m => '30 minutos';

  @override
  String get appBlockDuration1h => '1 hora';

  @override
  String get appBlockDuration2h => '2 horas';

  @override
  String get appBlockDuration4h => '4 horas';

  @override
  String get appBlockDurationAllDay => 'Todo el día (24 horas)';

  @override
  String get appBlockScheduleTitle => 'Horario de bloqueo';

  @override
  String get appBlockScheduleDesc => 'Establecer rangos horarios diarios';

  @override
  String get appBlockBlockedApps => 'Apps bloqueadas';

  @override
  String get appBlockNoApps => 'Aún no se han añadido apps';

  @override
  String get appBlockAddApp => 'Añadir app';

  @override
  String get appBlockPickerTitle => 'Elegir app';

  @override
  String get appBlockPresetWork => 'Horario laboral (09-18)';

  @override
  String get appBlockPresetSleep => 'Hora de dormir (23-07)';

  @override
  String get appBlockPresetAllDay => 'Todo el día';

  @override
  String get appBlockInterventionTitle => 'Espera un momento...';

  @override
  String get appBlockInterventionSubtitle => 'Respira y obsérvate a ti mismo';

  @override
  String get appBlockInterventionGiveUp => 'Paso';

  @override
  String get appBlockInterventionOpenAnyway => 'Abrir de todos modos';

  @override
  String get appBlockStrictModeActive => 'Modo estricto — no se puede abrir';

  @override
  String appBlockStatsTitle(String app, int hours) {
    return 'Pasaste $hours horas en $app esta semana';
  }

  @override
  String appBlockGaveUpCount(int count) {
    return 'Has renunciado $count veces este mes';
  }

  @override
  String get pickAppToBan => 'Elegir app para bloquear';

  @override
  String get pickAppToBanDesc =>
      'Tu oponente no podrá abrir esta app durante 24 horas';

  @override
  String get pickCategory => 'Elegir categoría';

  @override
  String get pickCategoryDesc => 'Solo cuenta el uso de esta categoría';

  @override
  String get rollDiceForTarget => 'Lanza el dado para tu objetivo';

  @override
  String get rollDiceDesc => 'Valor del dado × 30 minutos = duración objetivo';

  @override
  String get diceTapToRoll => 'Toca para lanzar';

  @override
  String get diceRolling => 'Lanzando...';

  @override
  String diceResult(int value) {
    return 'Resultado: $value';
  }

  @override
  String diceTargetDuration(int minutes) {
    return 'Duración objetivo: $minutes min';
  }

  @override
  String get chooseTeammates => 'Elegir compañeros';

  @override
  String teammatesSelected(int count) {
    return '$count/3 seleccionados  ·  Elige 2 o 3 compañeros';
  }

  @override
  String get nightDuelInfo => 'Duelo nocturno';

  @override
  String get nightDuelRange => '23:00 — 07:00';

  @override
  String get nightDuelBody =>
      'Duerme sin tocar tu teléfono. Quien aguante más gana. 8 horas fijas.';

  @override
  String get nightDuelAutoStart =>
      'Este duelo empieza automáticamente a las 23:00.';

  @override
  String get mysteryMissionTitle => 'Misión misteriosa';

  @override
  String get mysteryMissionSubtitle =>
      'Tu misión se revela cuando empieza el duelo';

  @override
  String get mysteryMissionBody =>
      'Cuando inicies el duelo, se elegirá una misión aleatoria.';

  @override
  String get mysteryStart => 'Iniciar misión';

  @override
  String opponentWantsToBanApp(String app) {
    return 'Tu oponente quiere que bloquees $app';
  }

  @override
  String opponentWantsCategory(String category) {
    return 'Tu oponente quiere competir en la categoría $category';
  }

  @override
  String get proposeDifferentApp => 'No tengo esa app, sugiere otra';

  @override
  String get proposeDifferentCategory => 'No uso esa categoría, sugiere otra';

  @override
  String get acceptInvite => 'Aceptar';

  @override
  String proposalSent(String value) {
    return 'Propuesta enviada: $value';
  }

  @override
  String get stepAppPicker => 'Elegir app';

  @override
  String get stepCategoryPicker => 'Elegir categoría';

  @override
  String get stepDice => 'Lanzar dado';

  @override
  String get stepNightInfo => 'Duelo nocturno';

  @override
  String get stepMystery => 'Misión misteriosa';

  @override
  String get stepTeamPicker => 'Elegir compañeros';
}
