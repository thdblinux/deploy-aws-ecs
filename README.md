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
👉 Além dos custos de transferência de dados, a AWS cobra por hora para cada NAT Gateway provisionado.

❗ Em caso de dúvida, use NAT Gateway para suas sub-redes. Use o IGW apenas se tiver certeza de que deseja que suas instâncias ou recursos sejam públicas.

## Observability and reliability

Priorizamos a observabilidade e a confiabilidade para garantir que nossa aplicação na AWS ECS esteja sempre em funcionamento e atendendo às expectativas dos usuários. Para isso, integramos ferramentas essenciais como o` Prometheus`,` Grafana `,` Alert Manager` e o `CloudWatch`. 

- **Prometheus**: Utilizamos o Prometheus para monitorar continuamente o desempenho da nossa aplicação. Ele coleta métricas vitais, como uso de CPU, memória e tempo de resposta dos serviços, oferecendo insights valiosos sobre o estado do sistema.
- **Grafana:** O Grafana é nossa ferramenta de visualização de métricas. Com ele, criamos dashboards personalizados que nos permitem monitorar o desempenho da aplicação de forma intuitiva e eficaz. Com gráficos e alertas configurados, podemos identificar rapidamente qualquer anomalia e tomar medidas proativas.
- **Alert Manager:** O Alert Manager complementa nossa estratégia de observabilidade, permitindo-nos configurar alertas com base em métricas específicas. Isso nos mantém informados sobre qualquer problema que possa surgir, garantindo uma resposta rápida e eficiente para minimizar qualquer impacto negativo na experiência do usuário.
Essas ferramentas trabalham em conjunto para garantir que tenhamos uma visão abrangente do nosso ambiente de produção, permitindo-nos detectar e responder a problemas de forma proativa, garantindo assim a confiabilidade contínua da nossa aplicação na AWS ECS.
- **CloudWatch:** Além disso, utilizamos o CloudWatch da AWS que por default ja fica associado a configuração do
ECS para monitoramento e gerenciamento de recursos na nuvem. Ele nos  nos fornece informações detalhadas sobre o desempenho dos serviços e nos permite configurar alarmes para eventos importantes, garantindo uma operação contínua e confiável da nossa aplicação na AWS ECS.

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

## Docker scout diagnostic vulnerability
![alt text](/assets/mando16.png)

## Tryvi scan diagnostic vulnerability
![alt text](/assets/mando17.png)

## Bucket S3
![alt text](/assets/mando19.png)

## Terraform uploading terraform.tfstate
![alt text](/assets/mando18.png)


## Links Refernces para a documentação das tecnologias utilizadas no projeto:

- [AWS caculator](https://calculator.aws/#/addService)
- [Terraform Manage AWS Auto Scaling Groups ASG](https://developer.hashicorp.com/terraform/tutorials/aws/aws-asg)
- [Terraform Resource AWS Auto Scaling Groups ASG](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group)
- [AWS Cloduwatch](https://aws.amazon.com/pt/cloudwatch/getting-started/)
- [AWS VPC peering](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-peering.html)
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
- [Terraform Resource launch template](https://registry.terraform.io/providers/-/aws/5.1.0/docs/resources/launch_template)
- [Terraform  count Meta-Arguments](https://developer.hashicorp.com/terraform/language/meta-arguments/count)
- [Terraform element Function](https://developer.hashicorp.com/terraform/language/functions/element)
- [Terraform AWS Getting Started ECR data](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecr_repository)
- [Terraform Data Source AWS availability zones](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones)
- [Terraform Configuration Language Guide](https://developer.hashicorp.com/terraform/tutorials/configuration-language/variables)
- [Workflow syntax for GitHub Actions](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)
- [Deploy to Amazon ECS](https://docs.github.com/en/actions/deployment/deploying-to-your-cloud-provider/deploying-to-amazon-elastic-container-service)