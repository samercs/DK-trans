<%@ Page Title="كشف حمولات السنوي" Language="C#" MasterPageFile="~/Admin/Reports.master" %>

<script runat="server">
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Header" Runat="Server">

    <table class="LogInTable" align="center">
        <tr>
            <td class="Title">
                كشف حركات السنوي <%=DateTime.Now.Year.ToString() %>
            </td>
        </tr>
        
        <tr>
                        <td align="center" colspan="2">
                            <table width="80%">
                                <tr>
                                    <td align="center">
                                        <a onclick="window.print();">
                                        <img width="20" height="20" src="../Images/printer.png" class="IconImg" />
                                        <br />
                                        طباعة
                                        </a>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                   </table>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Body" Runat="Server">

    <%
        
        DateTime date=new DateTime(DateTime.Now.Year,1,1);
        System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings["CS"].ConnectionString);
        System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand("select isnull(sum(tonnage),0) as m1,isnull(sum(tonnage2),0) as m2,isnull((sum(tonnage2)-sum(tonnage)),0) as m3 from transports where (year(leavingtime1)=@year and month(leavingtime1)=@month)", con);
        cmd.Parameters.AddWithValue("@year", date.Year);
        cmd.Parameters.AddWithValue("@month", date.Month);
        
        System.Data.SqlClient.SqlDataReader r;
        con.Open();
        System.Data.DataTable DT = new System.Data.DataTable();
        DT.Columns.Add("Day");
        DT.Columns.Add("m1",typeof(double));
        DT.Columns.Add("m2", typeof(double));
        DT.Columns.Add("m3", typeof(double));
        System.Data.DataRow row;
        double M1 = 0, M2 = 0, M3 = 0;
        int cyear=date.Year;
        while (date.Year == cyear)
        {

            r = cmd.ExecuteReader();
            if (r.Read())
            {
                row = DT.NewRow();
                row["day"] = date.Year.ToString() +"/"+ date.Month; 
                row["m1"] = r["m1"].ToString();
                row["m2"] = r["m2"].ToString();
                row["m3"] = r["m3"].ToString();
                DT.Rows.Add(row);
                M1 += double.Parse(r["m1"].ToString());
                M2 += double.Parse(r["m2"].ToString());
                M3 += double.Parse(r["m3"].ToString());
            }
            date = date.AddMonths(1);
            r.Close();
            cmd.Cancel();
            cmd.Parameters["@year"].Value = date.Year;
            cmd.Parameters["@month"].Value = date.Month;
            
            
            
        }

        con.Close();
        row = DT.NewRow();
        row["DAY"]="المجموع";
        row["m1"] = M1.ToString();
        row["m2"] = M2.ToString();
        row["m3"] = M3.ToString();
        DT.Rows.Add(row);
        GridView1.DataSource = DT;
        GridView1.DataBind();
        
        
         %>
    
    <asp:GridView AutoGenerateColumns="false" Width="100%" ID="GridView1" runat="server" CellPadding="4" ForeColor="#333333" 
        GridLines="None">
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <Columns>
            <asp:BoundField DataField="day" HeaderText="الشهر" SortExpression="day"  />
            <asp:BoundField DataField="m1" HeaderText="مجموع الحمولة" SortExpression="m1" DataFormatString="{0:###,###,###}" />
            <asp:BoundField DataField="m2" HeaderText="مجموع التفريغ" SortExpression="m2" DataFormatString="{0:###,###,###}" />
            <asp:BoundField DataField="m3" HeaderText="مجموع الصافي" SortExpression="m3" DataFormatString="{0:###,###,###}" />
            
        </Columns>
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#999999" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        
    </asp:GridView>
    
</asp:Content>
