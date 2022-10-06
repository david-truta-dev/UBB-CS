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
            adapterTable2.Update(dataSet, "Book");
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            //get data from DB:
            sqlConnection = new SqlConnection("Data Source=my-Laptop; Initial Catalog=LibrarySystem; Integrated Security=True");
            dataSet = new DataSet();
            adapterTable1 = new SqlDataAdapter("Select * from Section", sqlConnection);
            adapterTable2 = new SqlDataAdapter("Select * from Book", sqlConnection);
            cb = new SqlCommandBuilder(adapterTable2);
            adapterTable1.Fill(dataSet, "Section");
            adapterTable2.Fill(dataSet, "Book");


            DataRelation dr = new DataRelation("FK_Section_Book", dataSet.Tables["Section"].Columns["id"], dataSet.Tables["Book"].Columns["sectionId"]);
            dataSet.Relations.Add(dr);

            //data binding: 
            bindingSourceTable1 = new BindingSource();
            bindingSourceTable1.DataSource = dataSet;
            bindingSourceTable1.DataMember = "Section";
            bindingSourceTable2 = new BindingSource();
            bindingSourceTable2.DataSource = bindingSourceTable1;
            bindingSourceTable2.DataMember = "FK_Section_Book";
            dataGridView1.DataSource = bindingSourceTable1;
            dataGridView2.DataSource = bindingSourceTable2;

        }
    }
}
