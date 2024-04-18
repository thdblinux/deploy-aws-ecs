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

Qual é a diferença entre hashtag#AWS NAT Gateway e Internet Gateway? 

Ambos facilitam o fluxo de internet para a infraestrutura AWS. Ambos são anexados a sub-redes usando tabelas de roteamento.

Veja como eles se diferem


🌐 Internet Gateway hashtag#IGW
👉 Permite que instâncias ou recursos em uma subnet pública iniciem solicitações para a Internet. Também permite que solicitações de entrada iniciadas pela Internet cheguem a essas instâncias usando seu endereço IP público.
👉 Usado para instâncias públicas que precisam de saída para a Internet e também permitem tráfego de entrada da Internet (por exemplo, Load Balancer como NginX, servidores API/Frontend, etc.)
👉 Você só é cobrado pela transferência de dados. Não há cobrança pelo gateway em si.


🌐 NAT Gateway hashtag#NAT
👉 Permite que instâncias em uma sub-rede privada iniciem solicitações para a Internet. Mas não permite que solicitações de entrada iniciadas na Internet cheguem a essas instâncias.
👉 É mais seguro porque protege seus servidores do mundo exterior.
👉 Usado para instâncias privadas que requerem acesso à Internet (por exemplo, máquinas de banco de dados, API's, etc.).
👉 Além dos custos de transferência de dados, a AWS cobra por hora para cada NAT Gateway provisionado.

❗ Em caso de dúvida, use NAT Gateway para suas sub-redes. Use o IGW apenas se tiver certeza de que deseja que suas instâncias ou recursos sejam públicas.
