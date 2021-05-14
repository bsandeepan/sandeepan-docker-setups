from pyodbc import connect
from dataclasses import dataclass
import humps


@dataclass
class SqlServer:
    host: str = "sql server hostname"
    port: str = "1433"
    uid: str = "sql server user id"
    pwd: str = "sql server user password"
    driver: str = "{ODBC Driver 17 for SQL Server}"
    database: str = "sql server database"

    @property
    def connection_string_pyodbc(self):
        return f"DRIVER={self.driver};SERVER={self.host};PORT={self.port};" \
               f"DATABASE={self.database};UID={self.uid};PWD={self.pwd}"

    @staticmethod
    def get_cursor(connection_str):
        return connect(connection_str).cursor()


if __name__ == "__main__":
    test_hump = humps.decamelize("testDisBUMP")
    print(test_hump)

    sql_server = SqlServer()
    cursor = sql_server.get_cursor(sql_server.connection_string_pyodbc)
    cursor.execute("SELECT * from dbo.exampletable")
    for row in cursor:
        print(row)
