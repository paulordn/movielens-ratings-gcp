"""Separa o CSV exportado por scripts/extract_ddl.sql em um arquivo .sql por objeto.

Uso:
    python scripts/split_ddl.py ddl_export.csv
    python scripts/split_ddl.py ddl_export.csv --mask-project

--mask-project substitui o ID do projeto GCP por `seu-projeto-gcp` nos arquivos gerados.
"""

import argparse
import csv
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SQL_DIR = ROOT / "sql"


def target_dir(schema: str, table_type: str) -> Path:
    if table_type == "VIEW":
        return SQL_DIR / "03_views"
    if schema == "netflix_raw":
        return SQL_DIR / "01_raw"
    return SQL_DIR / "02_analytical"


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("csv_path", type=Path)
    parser.add_argument("--mask-project", action="store_true")
    args = parser.parse_args()

    csv.field_size_limit(sys.maxsize if sys.maxsize < 2**31 else 2**31 - 1)
    with args.csv_path.open(encoding="utf-8-sig", newline="") as f:
        rows = list(csv.DictReader(f))

    for row in rows:
        ddl = row["ddl"].strip()
        if args.mask_project:
            # `projeto.dataset.objeto` -> `seu-projeto-gcp.dataset.objeto`
            ddl = re.sub(r"`[a-z][a-z0-9-]{4,28}[a-z0-9]\.(netflix_\w+)", r"`seu-projeto-gcp.\1", ddl)

        out_dir = target_dir(row["table_schema"], row["table_type"])
        out_dir.mkdir(parents=True, exist_ok=True)
        out_file = out_dir / f"{row['table_name']}.sql"
        out_file.write_text(ddl.rstrip(";") + ";\n", encoding="utf-8")
        print(f"{out_file.relative_to(ROOT)}")

    print(f"\n{len(rows)} arquivos gerados.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
