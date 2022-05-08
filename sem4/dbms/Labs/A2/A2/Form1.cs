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
using System.Configuration;

namespace A2
{
    public partial class Form1 : Form
    {
        SqlConnection sqlConnection;
        SqlDataAdapter adapterTable1;
        SqlDataAdapter adapterTable2;
        DataSet dataSet;
        SqlCommandBuilder cb;
        BindingSource bindingSourceTable1, bindingSourceTable2;
        String table1;
        String table2;

        public Form1()
        {
            InitializeComponent();
        }


        private void button1_Click_1(object sender, EventArgs e)
        {
            adapterTable2.Update(dataSet, table2);
        }

        private void Form1_Load_1(object sender, EventArgs e)
        {
            //get data from DB:
            sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["cs"].ConnectionString);
            dataSet = new DataSet();
            adapterTable1 = new SqlDataAdapter(ConfigurationManager.AppSettings["q1"], sqlConnection);
            adapterTable2 = new SqlDataAdapter(ConfigurationManager.AppSettings["q2"], sqlConnection);
            cb = new SqlCommandBuilder(adapterTable2);
            table1 = ConfigurationManager.AppSettings["t1"];
            table2 = ConfigurationManager.AppSettings["t2"];
            adapterTable1.Fill(dataSet, table1);
            adapterTable2.Fill(dataSet, table2);


            DataRelation dr = new DataRelation("FK_t1_t2", dataSet.Tables[table1].Columns[ConfigurationManager.AppSettings["t1IdName"]], dataSet.Tables[table2].Columns[ConfigurationManager.AppSettings["t2FKIdName"]]);
            dataSet.Relations.Add(dr);

            //data binding: 
            bindingSourceTable1 = new BindingSource();
            bindingSourceTable1.DataSource = dataSet;
            bindingSourceTable1.DataMember = table1;
            bindingSourceTable2 = new BindingSource();
            bindingSourceTable2.DataSource = bindingSourceTable1;
            bindingSourceTable2.DataMember = "FK_t1_t2";
            dataGridView1.DataSource = bindingSourceTable1;
            dataGridView2.DataSource = bindingSourceTable2;
        }

    }
}
