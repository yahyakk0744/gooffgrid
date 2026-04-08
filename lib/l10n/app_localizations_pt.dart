// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'gooffgrid';

  @override
  String get appSlogan => 'Desconecte-se. Jogue. Não se perca no digital.';

  @override
  String get home => 'Início';

  @override
  String get ranking => 'Classificação';

  @override
  String get duel => 'Duelo';

  @override
  String get profile => 'Perfil';

  @override
  String get settings => 'Configurações';

  @override
  String get stories => 'Histórias';

  @override
  String get today => 'Hoje';

  @override
  String get thisWeek => 'Esta semana';

  @override
  String get friends => 'Amigos';

  @override
  String get friendsOf => 'Amigos de';

  @override
  String get allFriends => 'Todos';

  @override
  String get city => 'Cidade';

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
  String get screenTime => 'Tempo de tela';

  @override
  String get phonePickups => 'Vezes que pegou o celular';

  @override
  String pickupsToday(int count) {
    return 'Pegou o celular $count vezes hoje';
  }

  @override
  String get topTriggers => 'Principais gatilhos';

  @override
  String get longestOffScreen => 'Maior tempo offline';

  @override
  String get dailyGoal => 'Meta diária';

  @override
  String goalHours(int count) {
    return 'Meta: $count horas';
  }

  @override
  String get streak => 'Sequência';

  @override
  String streakDays(int count) {
    return '$count dias';
  }

  @override
  String get level => 'Nível';

  @override
  String get badges => 'Conquistas';

  @override
  String get duels => 'Duelos';

  @override
  String get activeDuels => 'Ativos';

  @override
  String get pastDuels => 'Anteriores';

  @override
  String get createDuel => 'Criar duelo';

  @override
  String get startDuel => 'Iniciar duelo';

  @override
  String get invite => 'Convidar';

  @override
  String get accept => 'Aceitar';

  @override
  String get decline => 'Recusar';

  @override
  String get win => 'Ganhou';

  @override
  String get lose => 'Perdeu';

  @override
  String get draw => 'Empate';

  @override
  String get addFriend => 'Adicionar amigo';

  @override
  String get friendCode => 'Código de amigo';

  @override
  String get search => 'Buscar';

  @override
  String get notifications => 'Notificações';

  @override
  String get dailyReminder => 'Lembrete diário';

  @override
  String get duelNotifications => 'Notificações de duelo';

  @override
  String get locationSharing => 'Compartilhar localização';

  @override
  String get subscription => 'Assinatura';

  @override
  String get free => 'Grátis';

  @override
  String get pro => 'Pro';

  @override
  String get proPlus => 'Pro+';

  @override
  String get currentPlan => 'Plano atual';

  @override
  String get recommended => 'Recomendado';

  @override
  String get start => 'Começar';

  @override
  String get upgradeToPro => 'Atualizar para Pro';

  @override
  String get upgradeToProPlus => 'Atualizar para Pro+';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String monthlyPrice(String price) {
    return '$price/mês';
  }

  @override
  String get freeFeature1 => 'Acompanhamento diário do tempo de tela';

  @override
  String get freeFeature2 => 'Classificações de amigos';

  @override
  String get freeFeature3 => '3 duelos ativos';

  @override
  String get freeFeature4 => 'Conquistas básicas';

  @override
  String get proFeature1 => 'Todas as classificações (cidade, país, global)';

  @override
  String get proFeature2 => 'Estatísticas detalhadas e calendário de foco';

  @override
  String get proFeature3 => 'Duelos ilimitados';

  @override
  String get proFeature4 => 'Passes Off-Grid incluídos';

  @override
  String get proFeature5 => 'Experiência sem anúncios';

  @override
  String get proPlusFeature1 => 'Tudo do Pro';

  @override
  String get proPlusFeature2 => 'Plano familiar (5 pessoas)';

  @override
  String get proPlusFeature3 => 'Suporte prioritário';

  @override
  String get proPlusFeature4 => 'Conquistas e temas exclusivos';

  @override
  String get proPlusFeature5 => 'Acesso antecipado a recursos beta';

  @override
  String get paywallTitle => 'Clube Off-Grid';

  @override
  String get paywallSubtitle => 'Seja recompensado por se desconectar.';

  @override
  String get logout => 'Sair';

  @override
  String get shareProfile => 'Compartilhar perfil';

  @override
  String get shareReportCard => 'Mostre o que tem';

  @override
  String get appUsage => 'Uso de aplicativos';

  @override
  String get whatDidYouUse => 'O que você usou hoje?';

  @override
  String get weeklyReport => 'Relatório semanal';

  @override
  String get weeklyTrend => 'Tendência de 7 dias';

  @override
  String get seasons => 'Temporadas';

  @override
  String get seasonPass => 'Passes Off-Grid';

  @override
  String get groups => 'Grupos';

  @override
  String get createGroup => 'Criar grupo';

  @override
  String get stats => 'Estatísticas';

  @override
  String get analytics => 'Análise';

  @override
  String get detailedAnalytics => 'Análise detalhada';

  @override
  String get categories => 'Categorias';

  @override
  String get weeklyUsage => 'Uso semanal';

  @override
  String get appDetails => 'Detalhes do app';

  @override
  String get focusCalendar => 'Calendário de foco';

  @override
  String get whatIf => 'E se?';

  @override
  String get focusMode => 'Respirar';

  @override
  String get startFocusMode => 'Iniciar modo foco';

  @override
  String get focusing => 'Você está focado...';

  @override
  String focusComplete(int minutes) {
    return 'Ótimo! Você ficou focado por $minutes min';
  }

  @override
  String get focusTimeout => 'Tempo limite da sessão';

  @override
  String get focusTimeoutDesc =>
      'Você atingiu o limite de 120 minutos.\nAinda está aí?';

  @override
  String get end => 'Encerrar';

  @override
  String get reportCard => 'Boletim';

  @override
  String get antiSocialStory => 'Momento anti-social';

  @override
  String get storyQuestion => 'O que você está fazendo longe do celular?';

  @override
  String get postStory => 'Publicar';

  @override
  String get storyExpired => 'Expirada';

  @override
  String get noStories => 'Nenhuma história ainda';

  @override
  String get noStoriesHint =>
      'Que seus amigos comecem a compartilhar seus momentos off-grid!';

  @override
  String get storyBlocked => 'Não é possível compartilhar uma história';

  @override
  String get storyBlockedHint =>
      'Você ultrapassou sua meta diária de tempo de tela. Cumpra sua meta para ganhar o direito de compartilhar histórias!';

  @override
  String get duration => 'Duração';

  @override
  String get walk => 'Caminhada';

  @override
  String get run => 'Corrida';

  @override
  String get book => 'Livro';

  @override
  String get meditation => 'Meditação';

  @override
  String get nature => 'Natureza';

  @override
  String get sports => 'Esportes';

  @override
  String get music => 'Música';

  @override
  String get cooking => 'Culinária';

  @override
  String get friendsActivity => 'Amigos';

  @override
  String get family => 'Família';

  @override
  String get o2Balance => 'Pontos O₂';

  @override
  String o2Remaining(int count) {
    return 'Restante: $count';
  }

  @override
  String o2Today(int earned, int max) {
    return 'Hoje: $earned/$max O₂';
  }

  @override
  String get o2Rules => 'Regras O₂';

  @override
  String get o2RuleTime => 'Ganho apenas entre 08:00 e 00:00';

  @override
  String get o2RuleDaily => 'Máx. 500 O₂ por dia';

  @override
  String get o2RuleFocus => 'Modo foco máx. 120 min';

  @override
  String get o2RuleTransfer => 'Sem transferências ou apostas';

  @override
  String o2Estimated(int amount) {
    return '+$amount O₂ (estimado)';
  }

  @override
  String get offGridMarket => 'Recompensas';

  @override
  String get offGridMarketHint => 'Converta pontos O₂ em recompensas reais';

  @override
  String get redeem => 'Resgatar';

  @override
  String get insufficient => 'Insuficiente';

  @override
  String get redeemSuccess => 'Parabéns!';

  @override
  String get couponCode => 'Seu código de cupom:';

  @override
  String get recentTransactions => 'Transações recentes';

  @override
  String get noTransactions => 'Ainda não há transações';

  @override
  String get categorySocial => 'Social';

  @override
  String get categoryGame => 'Jogos';

  @override
  String get categoryVideo => 'Vídeo';

  @override
  String get categoryAudio => 'Música';

  @override
  String get categoryProductivity => 'Produtividade';

  @override
  String get categoryNews => 'Notícias';

  @override
  String get categoryGames => 'Jogos';

  @override
  String get categoryShopping => 'Compras';

  @override
  String get categoryBrowser => 'Navegador';

  @override
  String get categoryMaps => 'Mapas';

  @override
  String get categoryImage => 'Fotos';

  @override
  String get categoryOther => 'Outros';

  @override
  String hello(String name) {
    return 'Olá, $name';
  }

  @override
  String get goalCompleted => 'Meta concluída!';

  @override
  String get dailyGoalShort => 'Meta diária';

  @override
  String get streakDaysLabel => 'dias seguidos';

  @override
  String get o2Label => 'O₂';

  @override
  String get rankLabel => 'rank';

  @override
  String get offlineLabel => 'offline';

  @override
  String get todaysApps => 'Apps de hoje';

  @override
  String get seeAll => 'Ver tudo';

  @override
  String get activeDuel => 'Duelo ativo';

  @override
  String get startDuelPrompt => 'Comece um duelo!';

  @override
  String get you => 'Você';

  @override
  String moreCount(int count) {
    return '+$count mais';
  }

  @override
  String get removeWithPro => 'Remover com Pro';

  @override
  String get adLabel => 'Anúncio';

  @override
  String get focus => 'Foco';

  @override
  String get legal => 'Legal';

  @override
  String get privacyPolicy => 'Política de Privacidade';

  @override
  String get termsOfService => 'Termos de Serviço';

  @override
  String get kvkkText => 'Aviso de Privacidade LGPD';

  @override
  String get deleteMyAccount => 'Excluir Minha Conta';

  @override
  String get edit => 'Editar';

  @override
  String get adminAddLoot => 'Admin: Adicionar Recompensa';

  @override
  String get continueConsent => 'Ao continuar você';

  @override
  String get acceptTermsSuffix => 'aceita.';

  @override
  String get alreadyHaveAccount => 'Já tenho uma conta';

  @override
  String get screenTimePermissionTitle =>
      'Precisamos rastrear seu tempo de tela';

  @override
  String get screenTimePermissionDesc =>
      'O acesso ao tempo de tela é necessário para ver quanto tempo você passa em cada app.';

  @override
  String get screenTimeGranted => 'Permissão de tempo de tela concedida!';

  @override
  String get continueButton => 'Continuar';

  @override
  String get skip => 'Pular';

  @override
  String get yourName => 'Seu Nome';

  @override
  String get nameHint => 'Digite seu nome';

  @override
  String get ageGroup => 'Faixa Etária';

  @override
  String get imReady => 'Estou Pronto';

  @override
  String get dailyGoalTitle => 'Sua Meta Diária';

  @override
  String get goalQuestion =>
      'Quantas horas de tempo de tela você busca por dia?';

  @override
  String get goalMotivational1 =>
      'Incrível! Uma meta real de desintoxicação digital 💪';

  @override
  String get goalMotivational2 => 'Uma meta equilibrada, você consegue! 🎯';

  @override
  String get goalMotivational3 =>
      'Um bom começo, você pode reduzir com o tempo 📉';

  @override
  String get goalMotivational4 => 'Passo a passo, cada minuto conta ⭐';

  @override
  String get next => 'Próximo';

  @override
  String hourShort(int count) {
    return '${count}h';
  }

  @override
  String get welcomeSlogan =>
      'Largue o celular. Supere seus amigos.\nSeja o #1 na sua cidade.';

  @override
  String get deleteAccount => 'Excluir conta';

  @override
  String get deleteAccountConfirm =>
      'Sua conta e todos os dados serão excluídos permanentemente. Esta ação não pode ser desfeita.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get ok => 'OK';

  @override
  String get error => 'Erro';

  @override
  String get tryAgain => 'Tentar novamente';

  @override
  String get loading => 'Carregando...';

  @override
  String get loadFailed => 'Falha ao carregar';

  @override
  String get noDataYet => 'Ainda não há dados';

  @override
  String get welcome => 'Bem-vindo';

  @override
  String get welcomeSubtitle => 'Largue o celular. Supere seus amigos.';

  @override
  String get continueWithGoogle => 'Continuar com Google';

  @override
  String get continueWithApple => 'Continuar com Apple';

  @override
  String get continueWithEmail => 'Continuar com e-mail';

  @override
  String get permissionsTitle => 'Permissões';

  @override
  String get permissionsSubtitle =>
      'Precisamos de permissão para rastrear seu tempo de tela.';

  @override
  String get grantPermission => 'Conceder permissão';

  @override
  String get setupProfile => 'Configurar perfil';

  @override
  String get displayName => 'Nome de exibição';

  @override
  String get selectCity => 'Selecionar cidade';

  @override
  String get selectGoal => 'Selecionar meta diária';

  @override
  String get noDuelsYet => 'Ainda não há duelos';

  @override
  String get noDuelsYetSubtitle => 'Comece seu primeiro duelo!';

  @override
  String get activeDuelsTitle => 'Duelos ativos';

  @override
  String get newDuel => 'Novo duelo';

  @override
  String get selectDuelType => 'Selecionar tipo de duelo';

  @override
  String get selectDurationStep => 'Selecionar duração';

  @override
  String get selectOpponent => 'Selecionar oponente';

  @override
  String get duelStartButton => 'Iniciar duelo! ⚔️';

  @override
  String get freePlanDuelLimit =>
      'O plano gratuito permite no máx. 3 duelos ativos! Atualize para Pro.';

  @override
  String get quickSelect => 'Seleção rápida';

  @override
  String get customDuration => 'Duração personalizada';

  @override
  String selectedDuration(String duration) {
    return 'Selecionado: $duration';
  }

  @override
  String get minDurationWarning => 'Você deve selecionar pelo menos 10 minutos';

  @override
  String get selectPenalty => 'Selecionar penalidade (opcional)';

  @override
  String get searchFriend => 'Buscar amigo...';

  @override
  String get inviteWithLink => 'Convidar com link 🔗';

  @override
  String todayMinutesLabel(int count) {
    return '${count}min hoje';
  }

  @override
  String duelRemaining(int h, int m) {
    return 'Faltam ${h}h ${m}m';
  }

  @override
  String get remainingTime => 'Tempo restante';

  @override
  String watchersCount(int count) {
    return '$count assistindo 👀';
  }

  @override
  String get giveUp => 'Desistir';

  @override
  String get duelWon => 'Você venceu! 🎉';

  @override
  String get duelLost => 'Você perdeu 😔';

  @override
  String get greatPerformance => 'Ótima performance!';

  @override
  String get betterNextTime => 'Na próxima vai!';

  @override
  String get revenge => 'Revanche 🔥';

  @override
  String get share => 'Compartilhar';

  @override
  String get selectFriend => 'Selecionar amigo';

  @override
  String get orSendLink => 'ou enviar link';

  @override
  String get social => 'Social';

  @override
  String get myFriends => 'Meus amigos';

  @override
  String get inMyCity => 'Na minha cidade';

  @override
  String get shareFirstStory =>
      'Seja o primeiro a compartilhar seu momento off-grid!';

  @override
  String get createStoryTitle => 'Compartilhar história';

  @override
  String get addPhoto => 'Adicionar foto';

  @override
  String get whatAreYouDoing => 'O que você está fazendo?';

  @override
  String get captionHint => 'O que você está fazendo longe do celular?';

  @override
  String get howLongVisible => 'Por quanto tempo deve ficar visível?';

  @override
  String get whoCanSee => 'Quem pode ver?';

  @override
  String get onlyFriends => 'Só meus amigos';

  @override
  String get cityPeople => 'Pessoas da minha cidade';

  @override
  String get photoStoriesPro =>
      'Histórias com foto são Pro! Configurações > Clube Off-Grid';

  @override
  String get camera => 'Câmera';

  @override
  String get gallery => 'Galeria';

  @override
  String get writeFirst => 'Escreva algo primeiro!';

  @override
  String get inappropriateContent => 'Conteúdo inapropriado detectado';

  @override
  String viewsCount(int count) {
    return '$count visualizações';
  }

  @override
  String get editProfile => 'Editar perfil';

  @override
  String get changePhoto => 'Mudar foto';

  @override
  String get firstName => 'Nome';

  @override
  String get firstNameHint => 'Seu nome';

  @override
  String get lastName => 'Sobrenome';

  @override
  String get lastNameHint => 'Seu sobrenome';

  @override
  String get usernameLabel => 'Nome de usuário';

  @override
  String get updateLocation => 'Atualizar localização';

  @override
  String get locationUnknown => 'Desconhecido';

  @override
  String get save => 'Salvar';

  @override
  String get usernameAvailable => 'Disponível';

  @override
  String get usernameTaken => 'Este nome de usuário já está em uso';

  @override
  String get usernameFormatError =>
      'Pelo menos 3 caracteres, apenas letras, números e _';

  @override
  String get profileUpdated => 'Perfil atualizado';

  @override
  String get photoSelectedDemo =>
      'Foto selecionada (não será enviada no modo demo)';

  @override
  String get locationError => 'Não foi possível obter a localização';

  @override
  String get errorOccurred => 'Ocorreu um erro';

  @override
  String get detailedScreenTime => 'Tempo de tela detalhado';

  @override
  String get monthlyTop10 => 'Top 10 do mês';

  @override
  String get searchHint => 'Buscar...';

  @override
  String get noFriendsYet => 'Ainda não há amigos';

  @override
  String get noFriendsHint => 'Comece adicionando um amigo';

  @override
  String get showQrCode => 'Mostre seu QR code';

  @override
  String get enterCode => 'Inserir código';

  @override
  String get inviteLinkShare => 'Compartilhar link de convite';

  @override
  String get startDuelAction => 'Iniciar duelo';

  @override
  String get pointsLabel => 'Pontos';

  @override
  String get mostUsedLabel => 'Mais usado:';

  @override
  String get recentBadges => 'Conquistas recentes';

  @override
  String get allBadgesLabel => 'Todas as conquistas';

  @override
  String get removeFriend => 'Remover amigo';

  @override
  String get removeFriendConfirm =>
      'Tem certeza que quer remover esta pessoa da sua lista de amigos?';

  @override
  String get remove => 'Remover';

  @override
  String get requestSent => 'Solicitação enviada';

  @override
  String get whatCouldYouDo => 'O que você poderia ter feito?';

  @override
  String get back => 'Voltar';

  @override
  String get weekly => 'Semanal';

  @override
  String get daily => 'Diário';

  @override
  String get mostUsedApps => 'Apps mais usados';

  @override
  String get unlockSection => 'Desbloqueios';

  @override
  String get selectedDayLabel => 'Dia selecionado';

  @override
  String get todayLabel => 'Hoje';

  @override
  String weeklyAvgLabel(int h, int m) {
    return 'Média diária: ${h}h ${m}m';
  }

  @override
  String get firstUnlock => 'Primeiro desbloqueio';

  @override
  String get mostOpened => 'Mais aberto';

  @override
  String get timesPickedUp => 'Vezes pego';

  @override
  String get openingCount => 'aberturas';

  @override
  String get notificationUnit => 'notificações';

  @override
  String get timesUnit => 'vezes';

  @override
  String get turkey => 'Türkiye';

  @override
  String get consecutiveDays => 'dias seguidos';

  @override
  String bestStreakLabel(int days) {
    return 'Melhor: $days dias';
  }

  @override
  String get seriFriends => 'Amigos';

  @override
  String get oxygenTitle => 'Oxigênio (O₂)';

  @override
  String get totalO2 => 'Total';

  @override
  String get remainingShort => 'Restante';

  @override
  String get noOffersYet => 'Ainda não há ofertas';

  @override
  String o2SpentMsg(int amount) {
    return '$amount O₂ gastos';
  }

  @override
  String get mapLoadFailed => 'Falha ao carregar o mapa';

  @override
  String confirmRedeemMsg(String reward) {
    return 'Deseja resgatar $reward?';
  }

  @override
  String itemReceived(String item) {
    return '$item resgatado!';
  }

  @override
  String get insufficientO2 => 'O₂ insuficiente';

  @override
  String get season1Title => 'Temporada 1';

  @override
  String get season1Subtitle => 'Despertar da Primavera';

  @override
  String get seasonPassBtn => 'Passe de Temporada (99TL)';

  @override
  String get seasonPassLabel => 'Passe de Temporada';

  @override
  String get noGroupsYet => 'Ainda não há grupos';

  @override
  String get noGroupsSubtitle => 'Crie um grupo com seus amigos';

  @override
  String get newGroup => 'Novo grupo';

  @override
  String memberCount(int count) {
    return '$count membros';
  }

  @override
  String get weeklyGoal => 'Meta semanal';

  @override
  String challengeProgress(int percent) {
    return '$percent% concluído';
  }

  @override
  String get membersLabel => 'Membros';

  @override
  String get inviteLink => 'Link de convite';

  @override
  String get linkCopied => 'Link copiado!';

  @override
  String get copy => 'Copiar';

  @override
  String get qrCode => 'QR Code';

  @override
  String get groupNameLabel => 'Nome do grupo';

  @override
  String get groupNameHint => 'Digite o nome do grupo';

  @override
  String get groupNameEmpty => 'O nome do grupo não pode estar vazio';

  @override
  String dailyGoalHours(int hours) {
    return 'Meta diária: $hours horas';
  }

  @override
  String get addMember => 'Adicionar membro';

  @override
  String selectedCount(int count) {
    return '$count selecionado(s)';
  }

  @override
  String get create => 'Criar';

  @override
  String groupCreated(String name) {
    return '$name criado!';
  }

  @override
  String invitedCount(int count) {
    return '$count pessoas convidadas';
  }

  @override
  String get screenTimeLower => 'tempo de tela';

  @override
  String get improvedFromLastWeek => '12% melhor que na semana passada';

  @override
  String get o2Earned => 'O₂ ganho';

  @override
  String get friendRank => 'Rank entre amigos';

  @override
  String cityRankLabel(String city) {
    return 'Rank em $city';
  }

  @override
  String get mostUsed => 'Mais usado';

  @override
  String get offGridClub => 'Clube Off-Grid';

  @override
  String get clubSubtitle =>
      'Conquiste o equilíbrio digital e seja recompensado.';

  @override
  String get planStarter => 'Iniciante';

  @override
  String get planStarterSubtitle => 'Comece com o básico';

  @override
  String get currentPlanBtn => 'Plano atual';

  @override
  String get billingMonthly => 'Mensal';

  @override
  String get billingYearly => 'Anual';

  @override
  String get yearlySavings => '33% de desconto';

  @override
  String get planComparison => 'Comparação de planos';

  @override
  String get breathTechniquesComp => 'Técnicas de respiração';

  @override
  String get activeDuelsComp => 'Duelos ativos';

  @override
  String get storyPhoto => 'Foto na história';

  @override
  String get heatMap => 'Mapa de calor';

  @override
  String get top10Report => 'Relatório Top 10';

  @override
  String get exclusiveBadges => 'Conquistas exclusivas';

  @override
  String get adFree => 'Sem anúncios';

  @override
  String get familyPlanComp => 'Plano familiar';

  @override
  String get familyReport => 'Relatório familiar';

  @override
  String get exclusiveThemes => 'Temas exclusivos';

  @override
  String get prioritySupport => 'Suporte prioritário';

  @override
  String get billingNote =>
      'A assinatura pode ser cancelada a qualquer momento.\nPagamento processado via App Store/Google Play.\nA assinatura é renovada automaticamente.';

  @override
  String get restoreSuccess => 'Compras restauradas!';

  @override
  String get restoreFailed => 'Nenhuma compra encontrada para restaurar.';

  @override
  String get packagesLoadFailed =>
      'Falha ao carregar os pacotes. Tente novamente.';

  @override
  String get themesTitle => 'Temas';

  @override
  String get themeLockedMsg =>
      'Este tema é Pro+! Configurações > Clube Off-Grid';

  @override
  String get familyPlanTitle => 'Plano Familiar';

  @override
  String get familyPlanLocked => 'Equilíbrio Digital Juntos';

  @override
  String get familyPlanLockedDesc =>
      'Adicione até 5 membros da família, estabeleçam metas juntos e recebam relatórios familiares semanais.';

  @override
  String get weeklyFamilyReport => 'Relatório Familiar Semanal';

  @override
  String get familyRanking => 'Classificação Familiar';

  @override
  String get totalOffline => 'Total Offline';

  @override
  String get average => 'Média';

  @override
  String get best => 'Melhor';

  @override
  String offlineTime(int h, int m) {
    return '${h}h ${m}m offline';
  }

  @override
  String get enterName => 'Digite o nome';

  @override
  String get cannotUndo => 'Esta ação não pode ser desfeita!';

  @override
  String get deleteWarningDesc =>
      'Ao excluir sua conta, os seguintes dados serão excluídos permanentemente:';

  @override
  String get deleteItem1 => 'Informações do perfil e avatar';

  @override
  String get deleteItem2 => 'Todas as estatísticas de tempo de tela';

  @override
  String get deleteItem3 => 'Lista de amigos e duelos';

  @override
  String get deleteItem4 => 'Histórias e comentários';

  @override
  String get deleteItem5 => 'Pontos O₂ e recompensas';

  @override
  String get deleteItem6 => 'Histórico de assinatura';

  @override
  String get deleteSubscriptionNote =>
      'Se você tiver uma assinatura ativa, deve cancelá-la primeiro pelo Apple App Store ou Google Play Store.';

  @override
  String get deleteConfirmCheck =>
      'Entendo que minha conta e todos os dados serão excluídos permanentemente.';

  @override
  String get deleteAccountBtn => 'Excluir Minha Conta Permanentemente';

  @override
  String get deleteErrorMsg => 'Ocorreu um erro. Tente novamente.';

  @override
  String get emailHint => 'E-mail';

  @override
  String get passwordHint => 'Senha';

  @override
  String get forgotPassword => 'Esqueci a senha';

  @override
  String get passwordResetSent => 'E-mail de redefinição de senha enviado.';

  @override
  String get signUp => 'Cadastrar';

  @override
  String get signIn => 'Entrar';

  @override
  String get orDivider => 'ou';

  @override
  String get continueWithGoogleShort => 'Continuar com Google';

  @override
  String get continueWithAppleShort => 'Continuar com Apple';

  @override
  String get noAccountYet => 'Não tem uma conta? ';

  @override
  String get adminExistingPoints => 'Pontos existentes';

  @override
  String get adminSearchPlace => 'Buscar lugar...';

  @override
  String get adminRewardTitle => 'Título da recompensa (ex. Café grátis)';

  @override
  String get adminO2Cost => 'Custo O₂';

  @override
  String get adminSave => 'Salvar';

  @override
  String get adminSaved => 'Salvo!';

  @override
  String get adminDeleteTitle => 'Excluir';

  @override
  String get adminDeleteMsg => 'Tem certeza que quer excluir este ponto?';

  @override
  String adminDeleteError(String error) {
    return 'Erro ao excluir: $error';
  }

  @override
  String get adminFillFields => 'Preencha a recompensa e o custo O₂';

  @override
  String breathCount(int count) {
    return '$count respirações';
  }

  @override
  String minutesRemaining(int count) {
    return 'Faltam ${count}min';
  }

  @override
  String focusMinutes(int count) {
    return 'Você ficou focado por $count minutos';
  }

  @override
  String get o2TimeRestriction => 'O₂ ganho apenas entre 08:00 e 00:00';

  @override
  String get breathTechniqueProMsg =>
      'Esta técnica é Pro! Configurações > Clube Off-Grid';

  @override
  String get inhale => 'Inspira';

  @override
  String get holdBreath => 'Segura';

  @override
  String get exhale => 'Expira';

  @override
  String get waitBreath => 'Aguarda';

  @override
  String get proMostPopular => 'Mais Popular';

  @override
  String get proFamilyBadge => 'FAMÍLIA';

  @override
  String get comparedToLastWeek => 'comparado à semana passada';

  @override
  String get appBlockTitle => 'Bloqueio de apps';

  @override
  String get appBlockSchedule => 'Agenda';

  @override
  String get appBlockEnableBlocking => 'Ativar bloqueio';

  @override
  String get appBlockActive => 'O bloqueio está ativo';

  @override
  String get appBlockInactive => 'O bloqueio está desativado';

  @override
  String get appBlockStrictMode => 'Modo rigoroso';

  @override
  String get appBlockStrictDesc =>
      'Não pode ser desativado até o temporizador terminar';

  @override
  String get appBlockStrictExpired => 'Temporizador expirado';

  @override
  String get appBlockStrictDurationTitle => 'Duração do modo rigoroso';

  @override
  String get appBlockDuration30m => '30 minutos';

  @override
  String get appBlockDuration1h => '1 hora';

  @override
  String get appBlockDuration2h => '2 horas';

  @override
  String get appBlockDuration4h => '4 horas';

  @override
  String get appBlockDurationAllDay => 'O dia todo (24 horas)';

  @override
  String get appBlockScheduleTitle => 'Agenda de bloqueio';

  @override
  String get appBlockScheduleDesc => 'Definir intervalos de tempo diários';

  @override
  String get appBlockBlockedApps => 'Apps bloqueados';

  @override
  String get appBlockNoApps => 'Nenhum app adicionado ainda';

  @override
  String get appBlockAddApp => 'Adicionar app';

  @override
  String get appBlockPickerTitle => 'Escolher app';

  @override
  String get appBlockPresetWork => 'Horário de trabalho (09-18)';

  @override
  String get appBlockPresetSleep => 'Hora de dormir (23-07)';

  @override
  String get appBlockPresetAllDay => 'O dia todo';

  @override
  String get appBlockInterventionTitle => 'Espera um segundo...';

  @override
  String get appBlockInterventionSubtitle => 'Respire e observe-se';

  @override
  String get appBlockInterventionGiveUp => 'Vou deixar pra lá';

  @override
  String get appBlockInterventionOpenAnyway => 'Abrir mesmo assim';

  @override
  String get appBlockStrictModeActive => 'Modo rigoroso — não é possível abrir';

  @override
  String appBlockStatsTitle(String app, int hours) {
    return 'Você passou $hours horas no $app esta semana';
  }

  @override
  String appBlockGaveUpCount(int count) {
    return 'Você desistiu $count vezes este mês';
  }

  @override
  String get pickAppToBan => 'Escolher app para banir';

  @override
  String get pickAppToBanDesc =>
      'Seu oponente não poderá abrir este app por 24 horas';

  @override
  String get pickCategory => 'Escolher categoria';

  @override
  String get pickCategoryDesc => 'Apenas o uso nesta categoria conta';

  @override
  String get rollDiceForTarget => 'Role o dado para seu objetivo';

  @override
  String get rollDiceDesc => 'Valor do dado × 30 minutos = duração alvo';

  @override
  String get diceTapToRoll => 'Toque para rolar';

  @override
  String get diceRolling => 'Rolando...';

  @override
  String diceResult(int value) {
    return 'Resultado: $value';
  }

  @override
  String diceTargetDuration(int minutes) {
    return 'Duração alvo: $minutes min';
  }

  @override
  String get chooseTeammates => 'Escolher colegas de equipe';

  @override
  String teammatesSelected(int count) {
    return '$count/3 selecionados  ·  Escolha 2 ou 3 colegas';
  }

  @override
  String get nightDuelInfo => 'Duelo noturno';

  @override
  String get nightDuelRange => '23:00 — 07:00';

  @override
  String get nightDuelBody =>
      'Durma sem tocar no celular. Quem aguentar mais vence. 8 horas fixas.';

  @override
  String get nightDuelAutoStart =>
      'Este duelo começa automaticamente às 23:00.';

  @override
  String get mysteryMissionTitle => 'Missão misteriosa';

  @override
  String get mysteryMissionSubtitle =>
      'Sua missão é revelada quando o duelo começa';

  @override
  String get mysteryMissionBody =>
      'Ao iniciar o duelo, uma missão aleatória é selecionada.';

  @override
  String get mysteryStart => 'Iniciar missão';

  @override
  String opponentWantsToBanApp(String app) {
    return 'Seu oponente quer que você banha $app';
  }

  @override
  String opponentWantsCategory(String category) {
    return 'Seu oponente quer competir na categoria $category';
  }

  @override
  String get proposeDifferentApp => 'Não tenho esse app, sugira outro';

  @override
  String get proposeDifferentCategory => 'Não uso essa categoria, sugira outra';

  @override
  String get acceptInvite => 'Aceitar';

  @override
  String proposalSent(String value) {
    return 'Proposta enviada: $value';
  }

  @override
  String get stepAppPicker => 'Escolher app';

  @override
  String get stepCategoryPicker => 'Escolher categoria';

  @override
  String get stepDice => 'Rolar dado';

  @override
  String get stepNightInfo => 'Duelo noturno';

  @override
  String get stepMystery => 'Missão misteriosa';

  @override
  String get stepTeamPicker => 'Escolher colegas';
}
