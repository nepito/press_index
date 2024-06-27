import os
import typer

def obtain_all_files_xlsx(folder_path: str) -> list:
    all_files_in_data = [file for _, _, file in os.walk(f"/workdir/data/{folder_path}")][0]
    return [file.split(".")[0].split("Team Stats ")[1] for file in all_files_in_data if file.split(".")[1] == "xlsx"]


def return_transformation_command(folder_path: str, xlsx_files: str, file_to_change):
    return f"in2csv '/workdir/data/{folder_path}/Team Stats {xlsx_files}.xlsx' > /workdir/data/{folder_path}/{file_to_change}.csv"

tx2c = typer.Typer(help="Awesome CLI user manager.")


@tx2c.command()
def main(folder_path: str = "serie_a_2023-24"):
    all_files_xlsx: list = obtain_all_files_xlsx(folder_path)
    files_to_change = [file.replace(" ","_") for file in all_files_xlsx]
    for old_file, new_file in zip(all_files_xlsx, files_to_change):
        os.system(return_transformation_command(folder_path, old_file, new_file))

if __name__ == "__main__":
    tx2c()