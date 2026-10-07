# 🎬 MovieLens Ratings no GCP

Pipeline de engenharia de dados no Google Cloud Platform usando o **MovieLens Beliefs Dataset 2024**: ingestão de arquivos brutos no Cloud Storage, carga e modelagem dimensional no BigQuery e dashboard analítico no Metabase.

## 🎯 Objetivo

Construir, de ponta a ponta, uma solução analítica sobre avaliações de filmes que:

- organize os dados em camadas (**raw → analítica → consumo**);
- aplique **modelagem dimensional** (fato e dimensão) no BigQuery;
- exponha **views** prontas para responder perguntas de negócio;
- entregue um **dashboard** no Metabase com os principais indicadores.

## 🏗️ Arquitetura

```mermaid
flowchart LR
    A[GroupLens<br/>MovieLens Beliefs 2024<br/>CSV] --> B[(Cloud Storage<br/>camada raw)]
    B --> C[(BigQuery<br/>netflix_raw)]
    C --> D[(BigQuery<br/>netflix_analytical<br/>dim_movies · fact_ratings)]
    D --> E[Views analíticas<br/>vw_*]
    E --> F[Metabase<br/>Dashboard]
```

| Camada | Serviço | Conteúdo |
|---|---|---|
| Raw (arquivos) | Cloud Storage | CSVs originais do dataset |
| Raw (tabelas) | BigQuery · `netflix_raw` | Tabelas espelhando os CSVs, sem transformação |
| Analítica | BigQuery · `netflix_analytical` | Modelo dimensional (`dim_movies`, `fact_ratings`) |
| Consumo | BigQuery · views `vw_*` | Métricas e agregações para o dashboard |
| Visualização | Metabase | Dashboard conectado ao BigQuery |

## 📦 Fonte dos dados

**MovieLens Beliefs Dataset 2024**, publicado pelo GroupLens Research (University of Minnesota):
<https://grouplens.org/datasets/movielens/ml_belief_2024/>

> ⚠️ **Aviso:** os dados **não são redistribuídos** neste repositório. Arquivos `.csv` e `.zip` estão no `.gitignore`. Para reproduzir o projeto, baixe o dataset diretamente no site do GroupLens e respeite os termos de uso e a licença definidos por eles (incluindo a citação do trabalho original).

Tabelas carregadas na camada raw (`netflix_raw`):

| Tabela | Descrição |
|---|---|
| `raw_movies` | Catálogo de filmes (título, gêneros) |
| `raw_user_rating_history` | Histórico de avaliações dos usuários |
| `raw_ratings_for_additional_users` | Avaliações de usuários adicionais |
| `raw_user_recommendation_history` | Histórico de recomendações exibidas aos usuários |
| `raw_movie_elicitation_set` | Conjunto de filmes usados na coleta de crenças |
| `raw_belief_data` | Crenças/expectativas dos usuários sobre filmes ainda não avaliados |

## ⭐ Modelo dimensional

```mermaid
erDiagram
    dim_movies ||--o{ fact_ratings : "movie_id"
    dim_movies {
        INT64 movie_id PK
        STRING title
        STRING genres
    }
    fact_ratings {
        INT64 user_id
        INT64 movie_id FK
        FLOAT64 rating
        TIMESTAMP rated_at
    }
```

- **`dim_movies`** — dimensão de filmes: um registro por filme, com título e gêneros.
- **`fact_ratings`** — fato de avaliações: granularidade de **uma avaliação por usuário, filme e momento**.

> Os DDLs completos estão em [`sql/02_analytical`](sql/02_analytical).

## 📊 Views analíticas

| View | Pergunta que responde |
|---|---|
| `vw_movies_kpis` | Quais são os números gerais da base (total de filmes, usuários, avaliações e nota média)? |
| `vw_top_movies` | Quais são os filmes mais bem avaliados (com volume mínimo de avaliações)? |
| `vw_genre_performance` | Quais gêneros têm mais avaliações e as melhores notas médias? |
| `vw_ratings_heatmap` | Em quais períodos (dia da semana × hora / mês) os usuários mais avaliam? |
| `vw_scatter_popularity_vs_quality` | Filmes mais populares são também os mais bem avaliados? |
| `vw_user_activity` | Como se distribui a atividade dos usuários (quantas avaliações cada um faz)? |

> Os SQLs das views estão em [`sql/03_views`](sql/03_views).

## 📈 Dashboard

Dashboard construído no Metabase consumindo as views acima:

![Dashboard no Metabase](images/dashboard.png)

## 📁 Estrutura do repositório

```
movielens-ratings-gcp/
├── sql/
│   ├── 01_raw/          # DDL das tabelas raw (netflix_raw)
│   ├── 02_analytical/   # DDL do modelo dimensional (netflix_analytical)
│   └── 03_views/        # Views analíticas
├── scripts/
│   ├── extract_ddl.sql  # Consulta ao INFORMATION_SCHEMA
│   └── split_ddl.py     # Gera um .sql por objeto a partir do export
├── images/
│   └── dashboard.png
└── README.md
```

### Como os SQLs foram extraídos

1. Rodar [`scripts/extract_ddl.sql`](scripts/extract_ddl.sql) no console do BigQuery e salvar o resultado como `ddl_export.csv`.
2. Gerar os arquivos:

   ```bash
   python scripts/split_ddl.py ddl_export.csv --mask-project
   ```

## 🛠️ Tecnologias

- **Google Cloud Storage** — data lake (camada raw)
- **Google BigQuery** — data warehouse, SQL e modelagem dimensional
- **Metabase** — visualização e dashboards
- **SQL** (GoogleSQL / BigQuery)
- **Python** — automação da extração dos DDLs
- **Git & GitHub** — versionamento

## 👤 Autor

**Paulo Rondon Barros**
