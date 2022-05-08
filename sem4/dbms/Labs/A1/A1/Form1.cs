using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace A1
{
    public partial class Form1 : Form
    {
        SqlConnection sqlConnection;
        SqlDataAdapter adapterTable1;
        SqlDataAdapter adapterTable2;
        DataSet dataSet;
        SqlCommandBuilder cb;
        BindingSource bindingSourceTable1, bindingSourceTable2;

        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            adapterTable2.Update(dataSet, "agent");
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            //get data from DB:
            sqlConnection = new SqlConnection("Data Source=my-Laptop; Initial Catalog=inchirieri; Integrated Security=True");
            dataSet = new DataSet();
            adapterTable1 = new SqlDataAdapter("Select * from agentie", sqlConnection);
            adapterTable2 = new SqlDataAdapter("Select * from agent", sqlConnection);
            cb = new SqlCommandBuilder(adapterTable2);
            adapterTable1.Fill(dataSet, "agentie");
            adapterTable2.Fill(dataSet, "agent");


            DataRelation dr = new DataRelation("FK_agentie_agent", dataSet.Tables["agentie"].Columns["id"], dataSet.Tables["agent"].Columns["agentie_id"]);
            dataSet.Relations.Add(dr);

            //data binding: 
            bindingSourceTable1 = new BindingSource();
            bindingSourceTable1.DataSource = dataSet;
            bindingSourceTable1.DataMember = "agentie";
            bindingSourceTable2 = new BindingSource();
            bindingSourceTable2.DataSource = bindingSourceTable1;
            bindingSourceTable2.DataMember = "FK_agentie_agent";
            dataGridView1.DataSource = bindingSourceTable1;
            dataGridView2.DataSource = bindingSourceTable2;

        }
    }
}
