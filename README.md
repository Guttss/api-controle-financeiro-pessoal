# Finance API

API REST para controle financeiro pessoal, criada com Spring Boot. O projeto permite cadastrar, listar, filtrar e excluir transacoes financeiras, separando receitas (`income`) e despesas (`expense`).

## Tecnologias

- Java 25
- Spring Boot
- Spring Web MVC
- Spring Data JPA
- MySQL
- Lombok
- Springdoc OpenAPI
- Maven

## Funcionalidades

- Cadastrar uma transacao financeira
- Listar todas as transacoes
- Listar transacoes por tipo
- Excluir transacao por ID
- Calcular o total acumulado com base em receitas e despesas

## Estrutura Principal

```text
src/main/java/finance_api
+-- controller
|   +-- TransactionController.java
+-- exception
|   +-- ApiException.java
|   +-- ErrorResponse.java
+-- model
|   +-- TransactionModel.java
+-- repository
|   +-- TransactionRepository.java
+-- service
|   +-- TransactionService.java
+-- FinanceApiApplication.java
```

## Configuracao do Banco de Dados

O projeto utiliza MySQL. Crie um banco de dados com o nome:

```sql
CREATE DATABASE db_financeiro;
```

Configure as variaveis de ambiente usadas em `application.properties`:

```properties
DB_USERNAME=seu_usuario_mysql
DB_PASSWORD=sua_senha_mysql
```

Configuracao atual da aplicacao:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/db_financeiro
spring.datasource.username=${DB_USERNAME}
spring.datasource.password=${DB_PASSWORD}
spring.jpa.hibernate.ddl-auto=update
```

## Como Executar

Clone o repositorio:

```bash
git clone <url-do-repositorio>
cd finance-api
```

Execute o projeto com Maven:

```bash
mvn spring-boot:run
```

A API ficara disponivel em:

```text
http://localhost:8080
```

## Endpoints

### Cadastrar Transacao

```http
POST /transactions
```

Exemplo de corpo da requisicao:

```json
{
  "amount": 1500.00,
  "date": "2026-05-28",
  "description": "Salario",
  "type": "income"
}
```

Tipos aceitos:

- `income`: receita
- `expense`: despesa

### Listar Todas as Transacoes

```http
GET /transactions
```

### Listar Transacoes por Tipo

```http
GET /transactions/{type}
```

Exemplos:

```http
GET /transactions/income
GET /transactions/expense
```

### Excluir Transacao

```http
DELETE /transactions/{id}
```

Exemplo:

```http
DELETE /transactions/1
```

## Documentacao da API

O projeto possui dependencia do Springdoc OpenAPI. Com a aplicacao em execucao, acesse:

```text
http://localhost:8080/swagger-ui.html
```

ou:

```text
http://localhost:8080/swagger-ui/index.html
```

## Exemplo de Objeto de Transacao

```json
{
  "id": 1,
  "amount": 1500.00,
  "date": "2026-05-28",
  "description": "Salario",
  "type": "income",
  "total": 1500.00
}
```

## Melhorias Futuras

- Adicionar validacoes nos campos da transacao
- Criar DTOs para entrada e saida de dados
- Trocar o campo `type` por um enum
- Criar endpoint especifico para consultar saldo total
- Adicionar paginacao na listagem de transacoes
- Criar testes unitarios e de integracao
- Adicionar autenticacao
- Adicionar Docker Compose para subir API e MySQL
- Configurar migrations com Flyway ou Liquibase

## Status

Projeto em desenvolvimento para estudo e pratica de APIs REST com Spring Boot.
