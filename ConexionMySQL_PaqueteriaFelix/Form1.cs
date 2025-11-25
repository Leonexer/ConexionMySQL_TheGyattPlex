using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MySql.Data.MySqlClient;

namespace ConexionMySQL_PaqueteriaFelix
{
    public partial class Form1 : Form
    {
        private MySqlConnection conexion;
        private MySqlDataAdapter adaptador;
        private DataTable tablaGlobal;
        string cadenaConexion = "Server=localhost; Database=The Gyatt Plex; Uid=root; Pwd=root;";

        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                conexion = new MySqlConnection(cadenaConexion);
                conexion.Open();
                MessageBox.Show("Conexión exitosa con la base de datos MySQL.");

                // Cargar nombres de tablas en el ComboBox
                string query = "SHOW TABLES;";
                MySqlCommand cmd = new MySqlCommand(query, conexion);
                MySqlDataReader reader = cmd.ExecuteReader();

                comboBox1.Items.Clear();

                while (reader.Read())
                {
                    comboBox1.Items.Add(reader[0].ToString());
                }

                reader.Close();
                conexion.Close();

                if (comboBox1.Items.Count > 0)
                    comboBox1.SelectedIndex = 0; // Seleccionar primera tabla automáticamente
            }
            catch (Exception ex)
            {
                MessageBox.Show(" Error: " + ex.Message);
            }
        }


        private void button2_Click(object sender, EventArgs e)
        {
            if (comboBox1.SelectedItem == null)
            {
                MessageBox.Show("Selecciona una tabla primero.");
                return;
            }

            try
            {
                string tablaSeleccionada = comboBox1.SelectedItem.ToString();

                conexion = new MySqlConnection(cadenaConexion);
                conexion.Open();

                string consulta = $"SELECT * FROM `{tablaSeleccionada}`;";
                MySqlCommand comando = new MySqlCommand(consulta, conexion);

                adaptador = new MySqlDataAdapter(comando);
                MySqlCommandBuilder builder = new MySqlCommandBuilder(adaptador);

                tablaGlobal = new DataTable();
                adaptador.Fill(tablaGlobal);

                dataGridView1.DataSource = tablaGlobal;

                conexion.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al cargar datos: " + ex.Message);
            }
        }

        private void CargarCamposDeTabla()
        {
            if (comboBox1.SelectedItem == null) return;

            string tabla = comboBox1.SelectedItem.ToString();
            panelCampos.Controls.Clear();

            try
            {
                conexion = new MySqlConnection(cadenaConexion);
                conexion.Open();

                string query = $"DESCRIBE `{tabla}`;";
                MySqlCommand cmd = new MySqlCommand(query, conexion);
                MySqlDataReader reader = cmd.ExecuteReader();

                int y = 10;

                while (reader.Read())
                {
                    string nombreColumna = reader.GetString("Field");

                    Label lbl = new Label();
                    lbl.Text = nombreColumna;
                    lbl.Location = new Point(10, y);
                    panelCampos.Controls.Add(lbl);

                    TextBox txt = new TextBox();
                    txt.Name = "txt_" + nombreColumna;
                    txt.Location = new Point(120, y);
                    txt.Width = 150;

                    panelCampos.Controls.Add(txt);

                    y += 30;
                }

                reader.Close();
                conexion.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error cargando columnas: " + ex.Message);
            }
        }

        private string ObtenerPK(string tabla)
        {
            string pk = null;
            try
            {
                conexion = new MySqlConnection(cadenaConexion);
                conexion.Open();
                string query = $"SHOW KEYS FROM `{tabla}` WHERE Key_name = 'PRIMARY';";
                MySqlCommand cmd = new MySqlCommand(query, conexion);
                MySqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    pk = reader.GetString("Column_name");
                }

                reader.Close();
                conexion.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al obtener PK: " + ex.Message);
            }

            return pk;
        }


        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                DataGridViewRow fila = dataGridView1.Rows[e.RowIndex];

                foreach (Control control in panelCampos.Controls)
                {
                    if (control is TextBox txt)
                    {
                        string columna = txt.Name.Replace("txt_", "");

                        if (fila.Cells[columna].Value != null)
                            txt.Text = fila.Cells[columna].Value.ToString();
                    }
                }
            }
        }

        private void buttonInsertar_Click(object sender, EventArgs e)
        {
            if (comboBox1.SelectedItem == null)
            {
                MessageBox.Show("Selecciona una tabla.");
                return;
            }

            string tabla = comboBox1.SelectedItem.ToString();

            try
            {
                conexion = new MySqlConnection(cadenaConexion);
                conexion.Open();

                // Construir INSERT dinámico
                List<string> columnas = new List<string>();
                List<string> valores = new List<string>();

                foreach (Control control in panelCampos.Controls)
                {
                    if (control is TextBox txt)
                    {
                        string columna = txt.Name.Replace("txt_", "");
                        columnas.Add($"`{columna}`");

                        // Preparar valores con comillas
                        valores.Add($"'{txt.Text}'");
                    }
                }

                string query =
                    $"INSERT INTO `{tabla}` ({string.Join(",", columnas)}) VALUES ({string.Join(",", valores)});";

                MySqlCommand cmd = new MySqlCommand(query, conexion);
                cmd.ExecuteNonQuery();

                MessageBox.Show("Registro insertado correctamente.");
                conexion.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error insertando: " + ex.Message);
            }
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            CargarCamposDeTabla();
        }

        private void panelCampos_Paint(object sender, PaintEventArgs e)
        {

        }

        private void buttonInsertar_Click_1(object sender, EventArgs e)
        {
            if (comboBox1.SelectedItem == null)
            {
                MessageBox.Show("Selecciona una tabla.");
                return;
            }

            string tabla = comboBox1.SelectedItem.ToString();

            try
            {
                conexion = new MySqlConnection(cadenaConexion);
                conexion.Open();

                // Construir INSERT dinámico
                List<string> columnas = new List<string>();
                List<string> valores = new List<string>();

                foreach (Control control in panelCampos.Controls)
                {
                    if (control is TextBox txt)
                    {
                        string columna = txt.Name.Replace("txt_", "");
                        columnas.Add($"`{columna}`");

                        // Preparar valores con comillas
                        valores.Add($"'{txt.Text}'");
                    }
                }

                string query =
                    $"INSERT INTO `{tabla}` ({string.Join(",", columnas)}) VALUES ({string.Join(",", valores)});";

                MySqlCommand cmd = new MySqlCommand(query, conexion);
                cmd.ExecuteNonQuery();

                MessageBox.Show("Registro insertado correctamente.");
                conexion.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error insertando: " + ex.Message);
            }
        }



        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void buttonGuardar_Click(object sender, EventArgs e)
        {
            if (tablaGlobal == null)
            {
                MessageBox.Show("No hay datos cargados para guardar.");
                return;
            }

            try
            {
                conexion = new MySqlConnection(cadenaConexion);
                conexion.Open();

                adaptador.Update(tablaGlobal);

                MessageBox.Show("Cambios guardados correctamente.");
                conexion.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al guardar los cambios: " + ex.Message);
            }
        }

        private void buttonEliminar_Click(object sender, EventArgs e)
        {
            if (comboBox1.SelectedItem == null || dataGridView1.CurrentRow == null)
            {
                MessageBox.Show("Selecciona una tabla y una fila para eliminar.");
                return;
            }

            string tabla = comboBox1.SelectedItem.ToString();
            DataGridViewRow fila = dataGridView1.CurrentRow;

            try
            {
                string pkNombre = tablaGlobal.Columns[0].ColumnName; // Primera columna como PK
                object pkValor = fila.Cells[pkNombre].Value;

                bool tieneIsActive = tablaGlobal.Columns.Contains("IsActive");

                string query;

                if (tieneIsActive)
                {
                    query = $"UPDATE `{tabla}` SET `IsActive` = 0 WHERE `{pkNombre}` = @valor;";
                }
                else
                {
                    query = $"DELETE FROM `{tabla}` WHERE `{pkNombre}` = @valor;";
                }

                using (MySqlConnection con = new MySqlConnection(cadenaConexion))
                {
                    con.Open();
                    MySqlCommand cmd = new MySqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@valor", pkValor);
                    cmd.ExecuteNonQuery();
                    con.Close();
                }

                // Ahora sí eliminamos la fila del DataTable
                tablaGlobal.Rows.RemoveAt(fila.Index);

                MessageBox.Show(tieneIsActive
                    ? "Registro desactivado correctamente."
                    : "Registro eliminado correctamente.");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error al eliminar/desactivar: " + ex.Message);
            }
        }

    }
}