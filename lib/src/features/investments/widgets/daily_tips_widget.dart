import 'package:flutter/material.dart';

class DailyTipsWidget extends StatelessWidget {
  const DailyTipsWidget({super.key});

  List get insights {
    return [
      {
        "title": "Faça uma Pesquisa Profunda:",
        "content":
            "Antes de investir em qualquer ação, faça uma pesquisa completa sobre a empresa, sua saúde financeira, perspectivas de crescimento e setor de atuação.",
      },
      {
        "title": "Diversifique sua Carteira:",
        "content":
            "Não coloque todos os ovos em uma cesta. Diversifique seus investimentos em diferentes setores e tipos de empresas para reduzir o risco.",
      },
      {
        "title": "Invista Regularmente:",
        "content":
            "Pratique o investimento sistemático, investindo regularmente uma quantia fixa, em vez de tentar cronometrar o mercado.",
      },
      {
        "title": "Acompanhe as Tendências do Mercado:",
        "content":
            "Esteja ciente das tendências econômicas e do mercado, e ajuste sua estratégia de investimento de acordo com elas.",
      },
      {
        "title": "Estabeleça Metas de Investimento:",
        "content":
            "Defina metas de curto, médio e longo prazo para seus investimentos na bolsa de valores.",
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final insight = insights[3];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              insight['title'],
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(
              insight['content'],
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
