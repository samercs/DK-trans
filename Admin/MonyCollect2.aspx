<%@ Page Title="مطالبة مالية" Language="C#" MasterPageFile="~/Admin/Reports.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
           
        }
    }

    
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Header" Runat="Server">
   <table width="100%">
        <tr style="font-size:10px;">
            <td style="text-align:right;">
            <%=DateTime.Now.ToShortDateString() %>
            </td>
            <td style="text-align:left;">
                <%=DateTime.Now.ToShortTimeString() %>
            </td>
                
        </tr>
        <tr>
            <td colspan="2" align="center">
                
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                مطالبة مالية من تاريخ &nbsp;&nbsp;&nbsp;&nbsp;<%=Session["d1"].ToString() %> &nbsp;&nbsp;&nbsp;&nbsp;الى تاريخ&nbsp;&nbsp;&nbsp;&nbsp;<%=Session["d2"].ToString() %> 
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                السعر القديم &nbsp;&nbsp;&nbsp;&nbsp; <%=Session["oldp"].ToString() %> &nbsp;&nbsp;&nbsp;&nbsp; السعر الجديد &nbsp;&nbsp;&nbsp;&nbsp;<%=Session["newp"].ToString() %>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                مطالبة رقم 
            </td>
        </tr>
   </table>
</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="Body" Runat="Server">
    
    <%
        
        System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["CS"].ConnectionString);
        System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand("select ToId,FromID,count(*) As C, SUM(ISNULL(CASE WHEN tonnage < tonnage2 THEN tonnage ELSE tonnage2 END, 0)) as m1 from transports where (((fromid=@fromid) and (toid=@toid)) and (DATEDIFF(dd,LeavingTime1,@d1)<=0 and DATEDIFF(dd,LeavingTime1,@d2)>=0)) Group By ToId,FromId", con);

        string[] dd1 = Session["d1"].ToString().Split('/');
        string[] dd2 = Session["d2"].ToString().Split('/');

        DateTime d1 = new DateTime(int.Parse(dd1[2]), int.Parse(dd1[1]), int.Parse(dd1[0]));
        DateTime d2 = new DateTime(int.Parse(dd2[2]), int.Parse(dd2[1]), int.Parse(dd2[0]));

        cmd.Parameters.AddWithValue("@d1", d1);
        cmd.Parameters.AddWithValue("@d2", d2);
        cmd.Parameters.Add("@fromid", Session["from"].ToString());
        cmd.Parameters.Add("@toid", Session["to"].ToString());
        con.Open();
        System.Data.SqlClient.SqlDataReader r = cmd.ExecuteReader();

        System.Data.DataTable DT = new System.Data.DataTable();
        DT.Columns.Add("m1", typeof(double));
        DT.Columns.Add("From");
        DT.Columns.Add("To");
        DT.Columns.Add("Mony", typeof(double));
        DT.Columns.Add("TravelCount", typeof(int));
        DT.Columns.Add("MonyBefor", typeof(double));
        DT.Columns.Add("Disc", typeof(double));
        DT.Columns.Add("Disc2", typeof(double));
		DT.Columns.Add("MonyAfter", typeof(double));
        System.Data.DataRow row;

        double m1 = 0, m2 = 0, m3 = 0, m4 = 0, m5 = 0;
        
        while (r.Read())
        {
            row = DT.NewRow();
            row["From"] = DataBase.GetPName("Centers","name","id",r["Fromid"].ToString());
            row["To"] = DataBase.GetPName("Centers","name","id",r["Toid"].ToString());
            row["m1"] = r["m1"].ToString();
            row["TravelCount"] = r["c"].ToString();
            double mony;
            
            mony = double.Parse(Session["oldpt"].ToString());
            
            row["Mony"] = mony;
            row["MonyBefor"] = mony * double.Parse(r["m1"].ToString());
            double oldprise = double.Parse(Session["oldp"].ToString());
            double newprise = double.Parse(Session["newp"].ToString());
			row["Disc2"]=(mony * 0.3 * ((newprise - oldprise) / oldprise)) + mony;
            row["Disc"] = ((mony * 0.3 * ((newprise - oldprise) / oldprise))) * double.Parse(r["m1"].ToString());
            row["MonyAfter"] = double.Parse(row["MonyBefor"].ToString()) + double.Parse(row["Disc"].ToString());
            DT.Rows.Add(row);

            m1 += double.Parse(r["m1"].ToString());
            m2 += double.Parse(row["MonyBefor"].ToString());
            m3 += int.Parse(row["TravelCount"].ToString());
            m4 += double.Parse(row["Disc"].ToString());
            m5 += double.Parse(row["MonyAfter"].ToString());
            
        }
        
        con.Close();

        row = DT.NewRow();
        row["From"] = "المجموع";
        row["To"] = "";
        row["m1"] = m1.ToString();
        row["MonyBefor"] = m2.ToString();
        row["TravelCount"] = m3.ToString();
        row["Disc"] = m4.ToString();
        row["MonyAfter"] = m5.ToString();
        
        
        
        DT.Rows.Add(row);

        GridView1.DataSource = DT;
        GridView1.DataBind();
        
   %>
   
    <asp:GridView GridLines="Both" ID="GridView1" runat="server" CellPadding="4" ForeColor="#333333" 
         Width="100%" AutoGenerateColumns="false">
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#999999" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        
        <Columns>
            <asp:BoundField DataField="From" HeaderText="من" SortExpression="From" />
            <asp:BoundField DataField="To" HeaderText="الى" SortExpression="To" />
            <asp:BoundField DataField="M1" HeaderText="الكمية المنقولة بالطن" SortExpression="m1" DataFormatString="{0:###,###,###}" />
            <asp:BoundField DataField="TravelCount" HeaderText="عدد الرحلات" SortExpression="TravelCount" />
            <asp:BoundField DataField="Mony" HeaderText="اجرة نقل الطن القديم" SortExpression="Mony" />
            <asp:BoundField DataField="Disc2" HeaderText="اجرة نقل الطن الحالي" SortExpression="Disc2" DataFormatString="{0:###.###}"  />
            <asp:BoundField DataField="MonyBefor" HeaderText="الاجور المستحقة قبل الخصم" SortExpression="MonyBefor" DataFormatString="{0:###,###,###}" />
            <asp:BoundField DataField="Disc" HeaderText="خصم فروقات الاجور" SortExpression="MonyAfter" DataFormatString="{0:###,###,###}" />
            <asp:BoundField DataField="MonyAfter" HeaderText="الاجور الصافية المستحقة" SortExpression="MonyAfter" DataFormatString="{0:###,###,###}" />
            
        </Columns>
    </asp:GridView>

    
  
    
</asp:Content>

