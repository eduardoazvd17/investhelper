// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'InvestHelper';

  @override
  String get aboutAppText => 'O InvestHelper é um aplicativo projetado para facilitar o gerenciamento dos seus investimentos. Com ele, você pode acompanhar seus investimentos, gerenciar suas transações e definir metas e lembretes para alcançar seus objetivos de investimento.';

  @override
  String get developedBy => 'Desenvolvido por';

  @override
  String get welcomeText1 => 'Seja bem-vindo ao seu novo aliado para conquistar seus objetivos financeiros! Comece a trilhar o caminho para uma jornada de investimentos bem-sucedida com nosso aplicativo.';

  @override
  String get welcomeText2 => 'Nosso aplicativo está aqui para simplificar sua vida financeira, permitindo que você acompanhe suas transações com facilidade e gere relatórios precisos e detalhados quando precisar.';

  @override
  String get welcomeText3 => 'Economize tempo e elimine o estresse na hora de gerenciar seus investimentos. Com nosso aplicativo intuitivo, você pode realizar tarefas em minutos que costumavam levar horas, liberando tempo valioso para aproveitar outras atividades da vida.';

  @override
  String get back => 'Voltar';

  @override
  String get next => 'Avançar';

  @override
  String get letsStart => 'Vamos começar';

  @override
  String get authPageLoginTitle => 'Entre com sua conta';

  @override
  String get authPageLoginSubtitle => 'Preencha os campos abaixo para iniciar a sessão';

  @override
  String get authPageRegisterTitle => 'Crie sua conta';

  @override
  String get authPageRegisterSubtitle => 'Preencha os campos abaixo para cadastrar-se no nosso app';

  @override
  String get authPageRecoveryTitle => 'Redefinição de senha';

  @override
  String get authPageRecoverySubtitle => 'Insira seu e-mail abaixo que lhe enviaremos um link para a redefinição de senha.';

  @override
  String get name => 'Nome';

  @override
  String get nameHint => 'Como você quer ser chamado?';

  @override
  String get email => 'E-mail';

  @override
  String get emailHint => 'login@exemplo.com';

  @override
  String get password => 'Senha';

  @override
  String get passwordHint => 'Insira sua senha...';

  @override
  String get passwordConfirmation => 'Confirmação de senha';

  @override
  String get passwordConfirmationHint => 'Repita a senha digitada anteriormente...';

  @override
  String get makeLogin => 'Iniciar sessão';

  @override
  String get login => 'Entrar';

  @override
  String get makeRegister => 'Concluir Cadastro';

  @override
  String get register => 'Cadastre-se';

  @override
  String get sendRecoveryEmail => 'Enviar e-mail de recuperação';

  @override
  String get forgotMyPassword => 'Esqueci minha senha';

  @override
  String get dontHaveAnAccountYet => 'Ainda não possui uma conta?';

  @override
  String get alreadyHaveAnAccount => 'Já possui uma conta?';

  @override
  String get myInvestments => 'Meus investimentos';

  @override
  String get totalInvestment => 'Total em investimentos';

  @override
  String get monthsOperations => 'Operações realizadas neste mês';

  @override
  String get purchaseOperations => 'Operações de compra';

  @override
  String get salesOperations => 'Operações de venda';

  @override
  String get seeMyOperations => 'Ver minhas operações';

  @override
  String get myGoals => 'Minhas metas';

  @override
  String get diversity => 'Diversidade';

  @override
  String get tips => 'Dicas';

  @override
  String get quickActions => 'Ações rápidas';

  @override
  String get insertPurchaseOperation => 'Inserir operação de compra';

  @override
  String get insertSaleOperation => 'Inserir operação de venda';

  @override
  String get editMyGoals => 'Editar minhas metas';

  @override
  String get overview => 'Visão geral';

  @override
  String get investments => 'Investimentos';

  @override
  String hiUser(String name) {
    return 'Olá, $name.';
  }

  @override
  String get accessMyInvestments => 'Acessar meus investimentos';

  @override
  String get categories => 'Categorias';

  @override
  String get productsAndServices => 'Produtos e serviços';

  @override
  String custodialPositionDisplay(String value) {
    return 'Posição em custódia: $value';
  }

  @override
  String amountInvestedDisplay(String value) {
    return 'Valor investido: $value';
  }

  @override
  String averagePriceDisplay(String value) {
    return 'Preço médio: $value';
  }

  @override
  String get operationsHistoryPerformed => 'Histórico de operações realizadas';

  @override
  String get settings => 'Configurações';

  @override
  String get myProfile => 'Meu perfil';

  @override
  String get changePersonalData => 'Alterar dados pessoais';

  @override
  String get endSession => 'Finalizar sessão';

  @override
  String get protection => 'Proteção';

  @override
  String get enableBiometrics => 'Habilitar Biometria';

  @override
  String get enableBiometricsHint => 'Proteja seus dados utilizando sua biometria para acessar o app.';

  @override
  String get personalization => 'Personalização';

  @override
  String get appTheme => 'Tema do app';

  @override
  String get appLanguage => 'Idioma do app';

  @override
  String get system => 'Sistema';

  @override
  String get lightMode => 'Modo claro';

  @override
  String get darkMode => 'Modo escuro';

  @override
  String get english => 'Inglês';

  @override
  String get portuguese => 'Português';

  @override
  String get others => 'Outros';

  @override
  String get aboutThisApp => 'Sobre este app';

  @override
  String get close => 'Fechar';

  @override
  String get genericErrorTitle => 'Erro inesperado';

  @override
  String get genericErrorMessage => 'Ocorreu um erro de comunicação, tente novamente em alguns segundos.';

  @override
  String get emptyFieldsErrorTitle => 'Um ou mais campos vazios';

  @override
  String get emptyFieldsErrorMessage => 'Alguma informação necessária está pendente, verifique o formulário e tente novamente.';

  @override
  String get incorrectUserOrPasswordErrorTitle => 'Usuário não encontrado';

  @override
  String get incorrectUserOrPasswordErrorMessage => 'O e-mail e/ou senha inseridos podem estar incorretos.';

  @override
  String get incorrectPasswordErrorTitle => 'Senha incorreta';

  @override
  String get incorrectPasswordErrorMessage => 'A senha atual inserida está incorreta.';

  @override
  String get userAlreadyExistsErrorTitle => 'Usuário já cadastrado';

  @override
  String get userAlreadyExistsErrorMessage => 'Já existe uma conta associada a este endereço de e-mail.';

  @override
  String get invalidEmailErrorTitle => 'E-mail inválido';

  @override
  String get invalidEmailErrorMessage => 'Digite um endereço de e-mail válido.';

  @override
  String get invalidPasswordErrorTitle => 'Senha inválida';

  @override
  String get invalidPasswordErrorMessage => 'A sua senha não pode conter menos de 8 caracteres.';

  @override
  String get passwordsDontMatchErrorTitle => 'Confirmação de senha inválida';

  @override
  String get passwordsDontMatchErrorMessage => 'A confirmação de senha deve ser extamente igual a sua senha.';

  @override
  String get invalidRecoveryEmailErrorTitle => 'E-mail inválido';

  @override
  String get invalidRecoveryEmailErrorMessage => 'Não existe uma conta associada a este endereço de e-mail.';

  @override
  String get recoveryEmailSentTitle => 'E-mail de recuperação enviado';

  @override
  String get recoveryEmailSentMessage => 'Se existir uma conta cadastrada com esse endereço e-mail, você receberá um link para redefinir sua senha.\n\nApós redefinir, faça login normalmente utilizando a sua nova senha.';

  @override
  String get connectionErrorTitle => 'Erro de conexão';

  @override
  String get connectionErrorMessage => 'Ocorreu um problema de conexão com o servidor, verifique sua conexão e tente novamente.';

  @override
  String get endSessionMessage => 'Deseja realmente sair da sua conta?';

  @override
  String get yes => 'Sim';

  @override
  String get no => 'Não';

  @override
  String get emptyDiversityGraphText => 'Adicione seus investimentos e operações para exibir o gráfico de diversidade.';

  @override
  String get emptyMyGoalsText => 'Não há metas definidas. Adicione metas ou lembretes e eles aparecerão aqui.';

  @override
  String get emptyInvestmentsText => 'Nenhum investimento adicionado. Adicione seus investimentos para começar a usar o app.';

  @override
  String get cantEnableBiometrics => 'Para habilitar a proteção biométrica do aplicativo, por favor, ative a biometria em seu dispositivo.';

  @override
  String get authRequired => 'Autenticação Necessária';

  @override
  String continueAs(String name) {
    return 'Continuar como: $name';
  }

  @override
  String get unlock => 'Desbloquear';

  @override
  String get stocks => 'Ações';

  @override
  String get mutualFunds => 'Fundos de Investimento';

  @override
  String get fixedIncome => 'Renda Fixa';

  @override
  String get reits => 'Fundos Imobiliários (FIIs)';

  @override
  String get treasuryBonds => 'Tesouro Direto';

  @override
  String get savingsAccount => 'Poupança';

  @override
  String get privatePensionPlans => 'Previdência Privada';

  @override
  String get commodities => 'Commodities';

  @override
  String get etfs => 'ETFs (Exchange Traded Funds)';

  @override
  String get cryptocurrencies => 'Criptomoedas';

  @override
  String get exportInvestmentReport => 'Exportar relatório de investimentos';

  @override
  String get emptyManageMyGoalsListing => 'Você ainda não possui metas adicionadas, utilize o botão flutuante para adicionar novas metas.';

  @override
  String get emptyManageMyInvestmentsListing => 'Você ainda não possui investimentos adicionados, utilize o botão flutuante para adicionar seus investimentos.';

  @override
  String get addNewGoal => 'Adicionar nova meta';

  @override
  String get description => 'Descrição';

  @override
  String get goalDescriptionHint => 'Utilize esse campo para descrever sua meta ou deixar uma anotação...';

  @override
  String get send => 'Enviar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get remove => 'Remover';

  @override
  String removeMessage(String name) {
    return 'Deseja realmente remover: $name?\n\nEsta alteração não poderá ser desfeita.';
  }

  @override
  String get editGoal => 'Editar meta';

  @override
  String get save => 'Salvar';

  @override
  String get addNewInvestment => 'Adicionar novo investimento';

  @override
  String get investmentNameHint => 'Insira o nome ou ticker do investimento';

  @override
  String get category => 'Categoria';

  @override
  String get selectCategory => 'Selecione a categoria...';

  @override
  String get addInvestmentsValuesAdvise => 'As informações abaixo são opcionais. Preencha apenas se não desejar inserir manualmente suas operações anteriores.\n\nAtenção: Utilize dados do seu banco/corretora de investimentos. Esse valores serão utilizados junto com suas operações futuras para atualizar seus dados.';

  @override
  String get addInvestmentsValuesAdvise2 => 'Ao inserir esses dados, você só conseguirá adicionar operações mais recentes, as operações devem ser adicionadas em ordem cronológica.';

  @override
  String get startCustodialPosition => 'Posição inicial';

  @override
  String get startAveragePrice => 'Preço médio inicial';

  @override
  String get editInvestment => 'Editar investimento';

  @override
  String get or => 'Ou';

  @override
  String get amountInvested => 'Total investido';

  @override
  String get changeName => 'Alterar nome';

  @override
  String quantityDisplay(String value) {
    return 'Quantidade: $value';
  }

  @override
  String unitPriceDisplay(String value) {
    return 'Preço unitário: $value';
  }

  @override
  String get emptyThisMonthOperations => 'Nenhuma operação realizada este mês, suas operações recentes aparecerão aqui. Para visualizar todas as operações, acesse suas operações clicando no botão abaixo.';

  @override
  String get accessMyOperations => 'Acessar minhas operações';

  @override
  String get myOperations => 'Minhas operações';

  @override
  String get emptyManageMyOperationsText => 'Nenhuma operação encontrada. Verifique os filtros selecionados ou caso ainda não possua operações, adicione utilizando o botão flutuante abaixo.';

  @override
  String get addNewOperation => 'Adicionar nova operação';

  @override
  String get editOperation => 'Editar operação';

  @override
  String get investment => 'Investimento';

  @override
  String get investmentHint => 'Selecione o investimento...';

  @override
  String get operationType => 'Tipo de operação';

  @override
  String get operationTypeHint => 'Selecione o tipo de operação...';

  @override
  String get operationDate => 'Data da operação';

  @override
  String get quantity => 'Quantidade';

  @override
  String get unitPrice => 'Preço unitário';

  @override
  String get totalPrice => 'Valor total';

  @override
  String get annotation => 'Anotações';

  @override
  String get optionalHint => '(Opcional)';

  @override
  String get purchase => 'Compra';

  @override
  String get sale => 'Venda';

  @override
  String operationDescription(String operation, String value, String investment) {
    return 'Operação de $operation no valor de $value do investimento $investment';
  }

  @override
  String positionDisplay(String value) {
    return 'Posição: $value';
  }

  @override
  String totalDisplay(String value) {
    return 'Total: $value';
  }

  @override
  String get salesOperationProfit => 'Lucro nas operações de venda';

  @override
  String profitDisplay(String value) {
    return 'Lucro: $value';
  }

  @override
  String get dontHaveInvestmentsTitle => 'Nenhum investimento adicionado';

  @override
  String get dontHaveInvestmentsMessage => 'Você ainda não possui investimentos adicionados.\n\nAdicione seus investimentos para começar a inserir as operações.';

  @override
  String get goToMyInvestments => 'Ir para meus investimentos';

  @override
  String get invalidValueErrorTitle => 'Valor inválido';

  @override
  String get invalidValueErrorMessage => 'Verifique os valores inseridos no formulário, os valores devem ser sempre maiores que 0.';

  @override
  String get operationsCronologicalOrderAdvise => 'Atenção: As operações são inseridas em ordem cronológica. Portanto ao adicionar uma operação em uma determinada data, você só poderá adicionar operações a partir dessa ultima data da operação inserida.\n\nO mesmo funciona para remover uma operação porém em ordem decrescente, deve-se remover da mais recente para a mais antiga.\n\nEssa é uma medida de segurança para garantir que o cálculo esteja 100% preciso.';

  @override
  String averagePriceVariationDisplay(String value) {
    return 'Variação P.M: $value';
  }

  @override
  String get operationsFiltersTitle => 'Filtrar operações';

  @override
  String get any => 'Qualquer';

  @override
  String get all => 'Todos';

  @override
  String fromDisplay(String value) {
    return 'De: $value';
  }

  @override
  String toDisplay(String value) {
    return 'Até: $value';
  }

  @override
  String get period => 'Período';

  @override
  String get orderByDate => 'Ordem por data';

  @override
  String get ascending => 'Crescente';

  @override
  String get descending => 'Decrescente';

  @override
  String get applyFilters => 'Aplicar filtros';

  @override
  String get resetFilters => 'Resetar filtros';

  @override
  String get pastMonth => 'Mês passado';

  @override
  String get thisMonth => 'Este mês';

  @override
  String get tryAgain => 'Tentar novamente';

  @override
  String get subscription => 'Assinatura';

  @override
  String subscriptionDisplay(String value) {
    return 'Assinatura: $value';
  }

  @override
  String get freeWithAdsSubscription => 'Gratuito (com anúncios)';

  @override
  String get monthlySubscription => 'Mensal';

  @override
  String get annualSubscription => 'Anual';

  @override
  String get unlimitedSubscription => 'Pro (ilimitado)';

  @override
  String get change => 'Alterar';

  @override
  String get functionNotImplementedTitle => 'Em breve';

  @override
  String get functionNotImplementedMessage => 'Esta funcionalidade ainda não foi implementada.\n\nAguarde as próximas versões.';

  @override
  String get termsOfUseTitle => 'Termos de uso e política de privacidade';

  @override
  String get termsOfUseMessage => 'Bem-vindo ao InvestHelper!\n\nAo utilizar nosso aplicativo, você concorda com os seguintes termos e condições:\n\n1. Propósito do Aplicativo: O InvestHelper é uma ferramenta projetada para auxiliar no controle dos seus investimentos. Não fornecemos conselhos ou recomendações de investimento. O aplicativo destina-se apenas a fins informativos e de registro pessoal.\n\n2. Responsabilidade do Usuário: Você é o único responsável pela precisão e integridade dos dados inseridos no InvestHelper. Não nos responsabilizamos por quaisquer erros ou informações incorretas fornecidas pelo usuário.\n\n3. Riscos de Investimento: É importante entender que investimentos financeiros estão sujeitos a riscos. O InvestHelper não garante resultados financeiros específicos e não oferece garantias de rentabilidade. Recomendamos que você busque orientação financeira profissional antes de tomar decisões de investimento.\n\n4. Privacidade e Proteção de Dados: Ao utilizar o InvestHelper, coletamos e armazenamos seu nome, endereço de e-mail e senha para autenticação de usuário. Também coletamos e armazenamos informações sobre seus investimentos, operações e metas inseridas dentro do aplicativo. Comprometemo-nos a proteger suas informações pessoais e a utilizar esses dados apenas para os fins descritos neste termo de uso e em conformidade com nossa política de privacidade.\n\n5. Segurança dos Dados: Implementamos medidas de segurança técnicas e organizacionais adequadas para proteger seus dados contra acesso não autorizado, uso indevido ou divulgação não autorizada.\n\n6. Consentimento do Usuário: Ao utilizar o InvestHelper, você consente com a coleta, uso e armazenamento de suas informações pessoais de acordo com os termos deste termo de uso e nossa política de privacidade.\n\n7. Exclusão de Dados: Você tem total liberdade para apagar seus dados pessoais diretamente pelo aplicativo, incluindo a opção de excluir sua conta. Você pode deletar os dados que desejar, inclusive deletar sua própria conta. Entre em contato conosco se precisar de assistência ou tiver alguma dúvida sobre o processo de exclusão de dados.\n\n8. Atualizações dos Termos de Uso e Política de Privacidade: Podemos revisar e atualizar estes termos de uso e nossa política de privacidade periodicamente. Notificaremos os usuários sobre quaisquer alterações significativas e solicitaremos seu consentimento, quando aplicável.\n\nAo clicar em \"Eu aceito\" ou continuar a utilizar o aplicativo, você concorda com estes termos de uso e nossa política de privacidade. Se você não concorda com estes termos, por favor, não use o InvestHelper.\n\nÚltima atualização: 13 de abril de 2024.';

  @override
  String get accept => 'Eu aceito';

  @override
  String get notAccept => 'Eu não aceito';

  @override
  String get deleteMyAccountTitle => 'Apagar minha conta e dados';

  @override
  String get deleteMyAccountMessage => 'Ao apagar sua conta, caso você possua uma assinatura ela será automaticamente cancelada e além disso, todos os seus dados inseridos no app serão apagados permanentemente junto com sua conta. Isso inclui investimentos, operações, metas...\n\nDeseja realmente apagar sua conta permanentemente?\n\nEsta ação não poderá ser desfeita.';

  @override
  String get changePassword => 'Alterar senha';

  @override
  String get currentPassword => 'Senha atual';

  @override
  String get newPassword => 'Nova senha';

  @override
  String get newPasswordConfirmation => 'Confirmação de nova senha';

  @override
  String get newPasswordHint => 'Insira uma nova senha';

  @override
  String get security => 'Segurança';

  @override
  String get continueWithGoogle => 'Continuar com Google';

  @override
  String get chooseYourPlan => 'Escolha seu plano';

  @override
  String get freeSubscriptionFeatures => 'Até 3 investimentos\nRecursos básicos\nCom anúncios';

  @override
  String get monthlySubscriptionFeatures => 'Investimentos ilimitados\nTodos os recursos\nSem anúncios\nSuporte prioritário';

  @override
  String get annualSubscriptionFeatures => 'Investimentos ilimitados\nTodos os recursos\nSem anúncios\nSuporte prioritário\n2 meses grátis';

  @override
  String get storeNotAvailableErrorTitle => 'Loja indisponível';

  @override
  String get storeNotAvailableErrorMessage => 'A loja de aplicativos está indisponível no momento. Por favor, tente novamente mais tarde.';

  @override
  String get productNotFoundErrorTitle => 'Produto não encontrado';

  @override
  String get productNotFoundErrorMessage => 'O produto da assinatura não foi encontrado. Por favor, tente novamente mais tarde.';

  @override
  String get purchaseErrorTitle => 'Erro na compra';

  @override
  String get purchaseErrorMessage => 'Ocorreu um erro ao processar sua compra. Por favor, tente novamente mais tarde.';

  @override
  String get subscriptionLimitReachedTitle => 'Limite de assinatura atingido';

  @override
  String get subscriptionLimitReachedMessage => 'Você atingiu o número máximo de investimentos para o plano gratuito. Por favor, faça um upgrade para continuar adicionando investimentos.';

  @override
  String get iosSubscriptionDisclaimer => 'O pagamento será cobrado na sua conta do Apple ID na confirmação da compra. A assinatura é renovada automaticamente, a menos que seja cancelada pelo menos 24 horas antes do final do período atual. Sua conta será cobrada pela renovação dentro de 24 horas antes do final do período atual. Você pode gerenciar e cancelar suas assinaturas indo para as configurações da sua conta na App Store após a compra.';

  @override
  String get error => 'Erro';

  @override
  String get purchasePendingErrorTitle => 'Compra em andamento';

  @override
  String get purchasePendingErrorMessage => 'Sua compra está sendo processada. Por favor, aguarde a confirmação.';

  @override
  String get success => 'Sucesso';

  @override
  String get planUpdated => 'Seu plano de assinatura foi atualizado com sucesso.';
}
