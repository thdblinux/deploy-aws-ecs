# Projeto: Criação de uma Infraestrutura para Ambientes de Stage e Produção na AWS, usando ECS e ECR.
![alt text](/assets/jupiner.png)

## Rolling update Blue/green VS Rolling Deployments Blue/green
**Rolling Update Blue/Green:** Nesta estratégia, duas versões da aplicação, geralmente chamadas de "blue" e "green", coexistem temporariamente durante o processo de implantação. A versão "blue" está em produção enquanto a nova versão (a "green") é implantada. Uma vez que a implantação da "green" é considerada bem-sucedida, o tráfego é direcionado para a nova versão, substituindo completamente a "blue". Esta abordagem permite uma implantação segura e sem tempo de inatividade, uma vez que o tráfego de produção é alternado de forma abrupta entre as versões.

**Rolling Deployments Blue/Green:** Similar à estratégia de atualização, mas com uma diferença chave. Em vez de alternar diretamente entre as versões "blue" e "green", ambas as versões são gradualmente implantadas e removidas. Durante a implantação, o tráfego é gradualmente roteado da versão "blue" para a "green". Isso permite uma implantação mais controlada e menos arriscada, pois qualquer problema com a nova versão pode ser detectado e corrigido antes de toda a carga de produção ser direcionada para ela.

Em essência, ambas as estratégias têm o mesmo objetivo: permitir a implantação de novas versões de aplicativos de forma segura e eficiente, minimizando o impacto nos usuários finais. A escolha entre as duas depende das necessidades específica

## Deploy CI/CD Blue/green ECS AWS
![alt text](/assets/mando1.png)

## DNS configurataion public IP
![alt text](/assets/mando8.png)

## Security and Finops 

Qual é a diferença entre AWS NAT Gateway e Internet Gateway? 

Ambos facilitam o fluxo de internet para a infraestrutura AWS. Ambos são anexados a sub-redes usando tabelas de roteamento.

Veja como eles se diferem


🌐 Internet Gateway IGW
👉 Permite que instâncias ou recursos em uma subnet pública iniciem solicitações para a Internet. Também permite que solicitações de entrada iniciadas pela Internet cheguem a essas instâncias usando seu endereço IP público.
👉 Usado para instâncias públicas que precisam de saída para a Internet e também permitem tráfego de entrada da Internet (por exemplo, Load Balancer como NginX, servidores API/Frontend, etc.)
👉 Você só é cobrado pela transferência de dados. Não há cobrança pelo gateway em si.


🌐 NAT Gateway NAT
👉 Permite que instâncias em uma sub-rede privada iniciem solicitações para a Internet. Mas não permite que solicitações de entrada iniciadas na Internet cheguem a essas instâncias.
👉 É mais seguro porque protege seus servidores do mundo exterior.
👉 Usado para instâncias privadas que requerem acesso à Internet (por exemplo, máquinas de banco de dados, API's, etc.).
👉 Além dos custos de transferência de dados, a` AWS` cobra por hora para cada` NAT Gateway` provisionado.

❗ Em caso de dúvida, use `NAT Gateway` para suas sub-redes. Use o IGW apenas se tiver certeza de que deseja que suas instâncias ou recursos sejam públicas.

A seguir, apresento alguns prints como resultado de uma configuração realizada através da tabela de roteamento, utilizando também o `gateway de internet` e o `NAT gateway` em sub-redes públicas e privadas para manter a comunicação entre as instâncias EC2. Na rede pública está minha aplicação, enquanto na rede privada está meu banco de dados `PostgreSQL`. Neste exemplo, acessei remotamente via `SSH` a instância pública e configurei um servidor de salto `(jump server)` para acessar a instância na rede privada e, assim, o banco de dados.

## EC2 subnet private database
![alt text](/assets/jump8.png)

## Route table private database
![alt text](/assets/jump7.png)

## VPC NAT and IGW network public database private database
![alt text](/assets/jump6.png)

## EC2 private database PostgreSQL jump server or bastion host
![alt text](/assets/jump10.png)

![alt text](/assets/jump5.png)


## Observability and reliability

Priorizamos a observabilidade e a confiabilidade para garantir que nossa aplicação na AWS ECS esteja sempre em funcionamento e atendendo às expectativas dos usuários. Para isso, integramos ferramentas essenciais como o` Prometheus`,` Grafana `,` Alert Manager` e o `CloudWatch`. 

- **Prometheus:** Utilizamos o Prometheus para monitorar continuamente o desempenho da nossa aplicação. Ele coleta métricas vitais, como uso de CPU, memória e tempo de resposta dos serviços, oferecendo insights valiosos sobre o estado do sistema.
- **Grafana:** O Grafana é nossa ferramenta de visualização de métricas. Com ele, criamos dashboards personalizados que nos permitem monitorar o desempenho da aplicação de forma intuitiva e eficaz. Com gráficos e alertas configurados, podemos identificar rapidamente qualquer anomalia e tomar medidas proativas.
- **Alert Manager:** O Alert Manager complementa nossa estratégia de observabilidade, permitindo-nos configurar alertas com base em métricas específicas. Isso nos mantém informados sobre qualquer problema que possa surgir, garantindo uma resposta rápida e eficiente para minimizar qualquer impacto negativo na experiência do usuário.
Essas ferramentas trabalham em conjunto para garantir que tenhamos uma visão abrangente do nosso ambiente de produção, permitindo-nos detectar e responder a problemas de forma proativa, garantindo assim a confiabilidade contínua da nossa aplicação na AWS ECS.
- **CloudWatch:** Além disso, utilizamos o CloudWatch da AWS que por default ja fica associado a configuração do
ECS para monitoramento e gerenciamento de recursos na nuvem. Ele nos  nos fornece informações detalhadas sobre o desempenho dos serviços e nos permite configurar alarmes para eventos importantes, garantindo uma operação contínua e confiável da nossa aplicação na AWS ECS.

## Security

- **Terraform Bucket S3 Armazenamento do arquivo terraform.tfstate:**
Utilizamos um bucket S3 para armazenar o arquivo `terraform.tfstate`. Isso nos permite manter um controle de estado remoto e compartilhado entre a equipe, garantindo consistência e segurança no provisionamento da infraestrutura.

- **SonarQube:**
Integramos o SonarQube ao nosso projeto para garantir a qualidade do código. O SonarQube analisa o código-fonte em busca de problemas de qualidade, bugs, vulnerabilidades de segurança e muito mais, fornecendo feedback valioso para garantir a robustez e a segurança da nossa aplicação.
- **Docker Scout:**
O Docker Scout é utilizado para realizar varreduras de segurança nas imagens Docker, ajudando a identificar e corrigir possíveis vulnerabilidades antes da implantação. Isso ajuda a manter um ambiente mais seguro e confiável para a execução da nossa aplicação.
- **Trivy:**
Integramos o Trivy ao nosso processo de construção de imagens Docker para identificar e corrigir quaisquer vulnerabilidades presentes nas dependências dos nossos contêineres. O Trivy fornece uma verificação de segurança rápida e abrangente, permitindo-nos garantir que nossas imagens Docker estejam livres de vulnerabilidades conhecidas.

## Prometheus metrcis
![alt text](/assets/mando10.png)

## Grafana Dashboard
![alt text](/assets/mando%2011.png)

## ECS Health and Metrics
![alt text](/assets/mando%2013.png)

## ECR Image container
![alt text](/assets/mando%2014.png)

## Website Front-end
![alt text](/assets/mando%2015.png)

## Docker diagnostic Image scan for vulnerability
![alt text](/assets/mando16.png)

## Tryvi diagnostic Image scan for vulnerability
![alt text](/assets/mando17.png)

## SonarQube diagnostic code scan for vulnerability
![Sonarqube](/assets/mando20.png)

## Bucket S3
![alt text](/assets/mando19.png)

## Terraform uploading terraform.tfstate
![alt text](/assets/mando18.png)


## Links References para a documentação das tecnologias utilizadas no projeto:

- [AWS caculator](https://calculator.aws/#/addService)
- [Terraform Manage AWS Auto Scaling Groups ASG](https://developer.hashicorp.com/terraform/tutorials/aws/aws-asg)
- [Terraform Resource AWS Auto Scaling Groups ASG](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group)
- [AWS Cloduwatch](https://aws.amazon.com/pt/cloudwatch/getting-started/)
- [Docker Builder Reference](https://docs.docker.com/engine/reference/builder/)
- [Docker Scout](https://docs.docker.com/scout/install/)
- [Acqua Security Tryvi](https://aquasecurity.github.io/trivy/v0.49/)
- [Prometheus](https://prometheus.io/docs/prometheus/latest/installation//)
- [Prometheus Blackbox Exporter](https://github.com/prometheus/blackbox_exporter)
- [Grafana](https://grafana.com/docs/grafana/latest/setup-grafana/installation/debian/)
- [Alert manager](https://prometheus.io/docs/alerting/latest/configuration/)
- [Sonarqube](https://www.sonarsource.com/products/sonarqube/)
- [Terraform Resource AWS Uploading a file to a bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object?ajs_aid=8b01d76d-0638-45bf-a23e-5dcb52151626&product_intent=terraform)
- [Terraform Backend S3](https://developer.hashicorp.com/terraform/language/settings/backends/s3)
- [Terraform AWS Getting Started ECS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service)
- [Terraform AWS Getting Started ALB](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb)
- [Terraform AWS Resource Tagging Guide](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/guides/resource-tagging)
- [Terraform AWS VPC Module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/2.15.0)
- [Terraform AWS Getting Started ECR resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository)
- [Terraform AWS EC2 ](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
- [Terraform User data](https://registry.terraform.io/providers/serverscom/serverscom/latest/docs/guides/user-data)
- [Terraform Resource launch template](https://registry.terraform.io/providers/-/aws/5.1.0/docs/resources/launch_template)
- [Terraform  count Meta-Arguments](https://developer.hashicorp.com/terraform/language/meta-arguments/count)
- [Terraform element Function](https://developer.hashicorp.com/terraform/language/functions/element)
- [Terraform AWS Getting Started ECR data](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecr_repository)
- [Terraform Data Source AWS availability zones](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones)
- [Terraform Configuration Language Guide](https://developer.hashicorp.com/terraform/tutorials/configuration-language/variables)
- [Workflow syntax for GitHub Actions](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)
- [Deploy to Amazon ECS](https://docs.github.com/en/actions/deployment/deploying-to-your-cloud-provider/deploying-to-amazon-elastic-container-service)

## Liderança da Track
 Track é uma Net Promoter Score e Customer Experience Management no Brasil.
 startup brasileira fundada em 2012 na cidade de Belo Horizonte 
 e liderada por Tomás Duarte (CEO), Luiz Carvalho (CDO) e José Luiz Choucaira (CFO)

## Cultura centrada no cliente: estratégia de fidelização de clientes!
1. Definir o foco no cliente como propósito da empresa
2. Definir valores da empresa que reflitam esse o foco no cliente
3. Difundir com clareza as funções  e respoonsabilidades de cada um no propósito de melhorar a vida do cliente
4. Ouvir o cliente interno da sua empresa encontrar oportunidades de melhoria e inovação
5. Acompanhar o mercado para compreender para onde as mudanças estão indo e aproveiotar as oportunidades

## Os princípios de Centralidade no Cliente da Track.co são fundamentais para sua cultura organizacional.

- 1. Cordialidade: Demonstre interesse genuíno em entender as necessidades e preocupações dos clientes. Pergunte como a empresa promove uma cultura de cordialidade em todas as interações com os clientes, tanto interna quanto externamente.
- 2. Resolutividade: Mostre sua capacidade de resolver problemas de forma eficiente e eficaz. Você pode perguntar como a empresa lida com desafios específicos de clientes e como incentiva a resolução rápida e satisfatória.
- 3. Data driven: Destaque a importância de tomar decisões com base em dados e métricas relevantes. Questione como a empresa utiliza dados de experiência do cliente para orientar suas estratégias e melhorar continuamente seus produtos e serviços.
- 4. Pontualidade: Enfatize a importância de cumprir prazos e compromissos com os clientes. Você pode perguntar como a empresa garante a entrega oportuna de soluções e como isso é integrado à cultura organizacional.
- 5. Básico bem feito: Demonstre seu compromisso com a excelência em todos os aspectos do trabalho. Questione como a empresa garante a qualidade consistente em todas as etapas da jornada do cliente e como isso se reflete em seus produtos e serviços.


Essas dimensões realmente fornecem uma estrutura sólida para uma empresa adotar um modelo centrado no cliente. É essencial que todas elas estejam em equilíbrio para garantir uma excelente experiência do cliente. Se uma delas for negligenciada, isso pode afetar negativamente toda a operação.

- 1. Pessoas comprometidas: São elas que dão vida aos processos e interagem diretamente com os clientes. Se não estiverem engajadas e comprometidas, a experiência do cliente pode ser afetada negativamente.
- 2. Processos bem estruturados: São fundamentais para garantir consistência e eficiência na entrega da experiência do cliente. Processos mal definidos podem levar a erros, atrasos e frustrações.
- 3. Ferramentas adequadas: Tecnologia desempenha um papel crucial na entrega de uma excelente experiência do cliente. Ferramentas inadequadas podem dificultar a interação com o cliente, prejudicar a personalização e limitar a capacidade de escalar as operações.
- 4. Gestão eficaz: Uma liderança forte e uma gestão eficaz são essenciais para garantir que a empresa esteja alinhada com as necessidades e expectativas do cliente. Decisões baseadas em dados e insights precisos ajudam a direcionar as estratégias de experiência do cliente de forma mais eficaz.
- 5. Cultura de foco no cliente: Esta é a cola que mantém todas as outras dimensões unidas. Uma cultura empresarial que valoriza e prioriza o cliente permeia todas as áreas da organização, garantindo que o cliente esteja sempre no centro das decisões e ações.
Ao fortalecer essas dimensões, uma empresa pode construir uma base sólida para uma estratégia de experiência do cliente sustentável a longo prazo, o que é essencial para o sucesso nos mercados cada vez mais competitivos de hoje.

## Sobre a Track.co:
- A Track.co é uma startup pioneira na metodologia de Net Promoter Score® no Brasil, especializada em indicadores de performance da Experiência do Cliente (CX).
- Eles têm um forte histórico de impacto, atingindo mais de 200 milhões de consumidores e 1.500 marcas em diversos países.
- A empresa oferece uma plataforma completa para rastreamento de dados de Experiência do Cliente em toda a jornada do consumidor.
- Eles são reconhecidos por seus indicadores de performance e monitoramento de métricas de CX.

# Modelo de Negocios

O modelo de negócios B2B da Track.co se concentra em fornecer soluções avançadas de rastreamento e análise de dados para empresas. Este modelo é construído em torno da prestação de serviços e plataformas personalizadas que ajudam outras empresas a otimizar suas operações, tomar decisões baseadas em dados e melhorar seu desempenho geral. A Track.co trabalha em estreita colaboração com seus clientes para entender suas necessidades específicas e oferecer soluções sob medida, aproveitando tecnologias de ponta, como inteligência artificial e análise de big data. Por meio de parcerias estratégicas e um foco contínuo na inovação, a Track.co busca proporcionar valor tangível aos seus clientes, ajudando-os a impulsionar o crescimento, aumentar a eficiência e alcançar seus objetivos de negócios.

## SLA, SLO e SLI: Medindo a Confiabilidade
- SLI (Service Level Indicator): Os SLIs são métricas quantificáveis que medem a qualidade do serviço. Eles são a base para definir SLOs e, por sua vez, contribuem para os SLAs. Por exemplo, um SLI pode ser a taxa de sucesso de uma operação.
- SLO (Service Level Objective): Os SLOs são metas específicas de desempenho que uma equipe de SRE define para cumprir os requisitos do SLA. Eles são mais detalhados e mensuráveis, contribuindo para a definição de padrões de qualidade.
- SLA (Service Level Agreement): Um SLA é um acordo formal entre um provedor de serviço e seus usuários, definindo os níveis aceitáveis de desempenho e disponibilidade. Ele estabelece expectativas claras e ajuda a manter um padrão elevado de serviço. Os SLAs geralmente incluem métricas como tempo de atividade e tempo de resposta.
## Ecossistema Track.co:
- A empresa oferece uma ampla gama de serviços, incluindo pesquisas multicanais de Net Promoter Score, plataforma de CXM para o setor de saúde e análise avançada de dados de CX através de IA generativa.
-Em breve, eles lançarão ferramentas como categorização de feedbacks de clientes, geração de sumários de feedbacks e criação de planos de ação baseados nos feedbacks.

## Perguntas sobre os Produtos e Ecossistema da Track.co:
- 1.**Sobre a Plataforma de CXM para o setor de saúde:** "Gostaria de saber mais sobre como a plataforma de CXM da Track.co é adaptada para o setor de saúde e quais funcionalidades específicas ela oferece?"
- 2. **Sobre a Análise de Dados de CX Avançada por meio de IA generativa:** "Como a análise de dados avançada por meio de IA generativa tem impactado positivamente a compreensão da experiência do cliente e as decisões estratégicas da empresa?"
- 3. **Sobre os Próximos Lançamentos de Ferramentas de Feedback:** "Estou interessado nos próximos lançamentos, como a ferramenta de categorização de feedbacks de clientes. Como vocês veem essas novas ferramentas impactando a maneira como lidam com feedbacks e promovem melhorias na experiência do cliente?"
- 4. **Sobre a Integração e Input de Dados:** "Como a integração e o input de dados são gerenciados na Track.co para garantir uma visão abrangente e precisa da experiência do cliente em todas as etapas da jornada?"
  

Considerações Finais:
Certifique-se de estar familiarizado com os valores e princípios da empresa, demonstrando seu alinhamento cultural durante a entrevista.
Prepare-se para compartilhar suas experiências relevantes em DevOps e SRE, destacando como suas habilidades podem contribuir para a missão e os objetivos da Track.co.
Mantenha uma abordagem positiva e demonstra interesse genuíno pelo trabalho da empresa e pelos desafios que ela enfrenta no campo da experiência do cliente.