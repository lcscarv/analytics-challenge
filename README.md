Este repositório contém um projeto de modelagem de dados utilizando o DBT (Data Build Tool) com a base de dados da Adventure Works. O objetivo é fornecer uma estrutura e pipeline de dados para análise e tomada de decisões usando a Adventure Works como fonte de dados.

Pré-requisitos
Antes de começar, verifique se você possui os seguintes itens instalados em sua máquina:

DBT versão 1.5.1): Ferramenta para orquestração e criação de modelos de dados.
Snowflake: Um data warehouse baseado em nuvem usado como destino dos dados modelados.
Banco de dados Adventure Works: O banco de dados da Adventure Works é necessário para este projeto. Certifique-se de ter acesso a sua conexão.
Configuração
Clone este repositório em sua máquina local:
'''
git clone Https://github.com/lcscarv/analytics-challenge.git
'''
Execute a criação de um ambiente virtual utilizando o comando
'''
python -m venv venv
'''
É recomendada que a versão do Python utilizada seja a versão 3.8 Caso haja mais de uma versão em sua máquina utilize o comando
'''
py -3.8 -m venv venv
'''
A ativação do ambiente virtual é feita pelos seguintes comandos
'''
Windows
source venv/scripts/activate
Linux
Source venv/bin/activate
Powershell
 .\venv\Scripts\activate.ps1
'''
 O próximo passo é instalar as bibliotecas listadas no arquivo **requirements.txt**. Isso pode ser executado através do [pip](https://pypi.org/project/pip/):
'''
- pip install -r requirements.txt ou

- python -m pip install -r requirements.txt para alguns casos em que o comando anterior não funciona.
'''
Configure as credenciais do banco de dados no arquivo .env. Substitua os valores <conta>, <warehouse>, <banco-de-dados>, <esquema>, <usuário> e <senha> pelas informações do seu ambiente Snowflake:
'''
export DBT_SF_DB_ACCOUNT=<conta>
export DBT_SF_DEV_USER=<usuário>
export DBT_SF_DEV_PASSWORD=<senha>
export DBT_SF_DEV_ROLE=<role>
export DBT_SF_DEV_DATABASE=<banco-de-dados>
export DBT_SF_DEV_WAREHOUSE=<warehouse>
export DBT_DEV_SCHEMA=<esquema>
'''
Após isso, rode o comando `source .env` no terminal (lembre-se de entar com a venv ativada)
Para testar se está funcionando, você pode rodar `echo $DBT_SF_DB_ACCOUNT` no terminal. Se retornar o valor que foi configurado, sua variável de ambiente está ativa.

Se você ainda não possui suas credenciais, solicite-as à/ao **Tech Lead do Projeto**.

Execute o seguinte comando para testar a conexão:
'''
dbt debug
'''
Execute o seguinte comando para instalar as dependências do projeto:
'''
dbt deps
'''

Este projeto utiliza o DBT para criar um pipeline de modelagem de dados. Os modelos são definidos na pasta models.

Para executar os modelos e carregar os dados, utilize o seguinte comando:

dbt run
Os resultados serão gerados na pasta target, e o banco de dados Snowflake será atualizado com as transformações de dados definidas nos modelos.

Contribuição
Contribuições são bem-vindas! Se você deseja contribuir com este projeto, siga os passos abaixo:

Faça um fork deste repositório.
Crie uma branch para a sua nova funcionalidade ou correção de bug: git checkout -b minha-funcionalidade.
Faça as alterações desejadas e adicione os arquivos modificados: git add .
Faça o commit das suas alterações: git commit -m "Adicionar nova funcionalidade"
Envie as suas alterações para o repositório remoto: git push origin minha-funcionalidade.
Abra um Pull Request no repositório original.
