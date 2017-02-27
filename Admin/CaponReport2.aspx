<%@ Page Title="تقرير الكابونات" Language="C#" MasterPageFile="Reports.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["d1"] == null)
        {
            Response.Redirect("CaponReport1.aspx");
        }
        
        DateTime tmp = DateTime.Parse(Session["d1"].ToString());
        DateTime d1 = new DateTime(tmp.Year, tmp.Month, tmp.Day);
        tmp = DateTime.Parse(Session["d2"].ToString());
        DateTime d2 = new DateTime(tmp.Year, tmp.Month, tmp.Day);
        SqlDataSource1.SelectParameters["d1"].DefaultValue = d1.ToString();
        SqlDataSource1.SelectParameters["d2"].DefaultValue = d2.ToString();
       
        SqlDataSource1.DataBind();
         
    }

    


    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        
    }

    private double GetSum(int Index)
    {
        double result = 0;
        
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            if (GridView1.Rows[i].RowType == DataControlRowType.DataRow)
            {
                string x = GridView1.Rows[i].Cells[Index].Text.Replace(",", "");
                double tmp;
                if(double.TryParse(x,out tmp))
                {
                    result+=tmp;
                }
            }
        }
        
        return result;
    }

    private double GetSum(int Index,string cname)
    {
        double result = 0;
        /*
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            if (GridView1.Rows[i].RowType == DataControlRowType.DataRow)
            {
                string x = ((Label)GridView1.Rows[i].FindControl(cname)).Text;
                double tmp;
                if (double.TryParse(x, out tmp))
                {
                    result += tmp;
                }
            }
        }
        */
        return result;
    }

    
</script>


<asp:Content ContentPlaceHolderID="Header" ID="c1" runat="server">
   
   <table width="100%" align="center">
    <tr style="font-size:10px;">
            <td style="text-align:right;">
            تاريخ الطباعة : <%=DateTime.Now.ToString("dd/MM/yyyy") %>
            </td>
            <td style="text-align:left;">
               ساعة الطباعة : <%=DateTime.Now.ToShortTimeString() %>
            </td>
                
        </tr>
    <tr>
        <td colspan="2" align="center">
            مؤسسة ابو حسين الذيابات للنقل
        </td>
    </tr>
     
        <td colspan="2" align="center"> تقرير الكابونات في الفترة من &nbsp;&nbsp;&nbsp;&nbsp;<%=DateTime.Parse(Session["d1"].ToString()).ToString("dd/MM/yyyy") %>  &nbsp;&nbsp;&nbsp;&nbsp;حتى&nbsp;&nbsp;&nbsp;&nbsp; <%=DateTime.Parse(Session["d2"].ToString()).ToString("dd/MM/yyyy") %></td>
    </tr>
     
    
   </table>
    
    
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Body" Runat="Server">
    
    <table width="100%">
        <tr>
            <td>
            
        
    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:CS %>" 
        
                    
                    SelectCommand="SELECT TransCapon.No AS capon_no, TransCapon.Type AS capon_type, Transports.LeavingTime1, Drivers.Name AS Driver_Name, Cars.Number AS Car_Number, Trailer.Number AS Trailer_Number, Centers.Name AS From_Name, Centers_1.Name AS To_Name FROM TransCapon INNER JOIN Transports ON TransCapon.TransID = Transports.id INNER JOIN Drivers ON Transports.DriverId = Drivers.id INNER JOIN Cars ON Transports.CarID = Cars.id INNER JOIN Trailer ON Transports.TrailerID = Trailer.id INNER JOIN Centers ON Transports.FromId = Centers.id INNER JOIN Centers AS Centers_1 ON Transports.ToId = Centers_1.id WHERE (DATEDIFF(dd, Transports.LeavingTime1, @d1) &lt;= 0) AND (DATEDIFF(dd, Transports.LeavingTime1, @d2) &gt;= 0) Order By Transports.LeavingTime1">
                    <SelectParameters>
                        <asp:Parameter Name="d1" />
                        <asp:Parameter Name="d2" />
                    </SelectParameters>
    </asp:SqlDataSource>
   
    <asp:GridView  AllowSorting="True" ID="GridView1" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" Width="100%" 
                    HorizontalAlign="Right" OnRowDataBound="GridView1_RowDataBound">
        <RowStyle  BackColor="#ffffff" HorizontalAlign="Center" ForeColor="#000000" />
        <EmptyDataRowStyle CssClass="Title" HorizontalAlign="Center" />
        <EmptyDataTemplate>
            لا يوجد بيانات
        </EmptyDataTemplate>
        
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Label ID="no" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:BoundField DataField="Capon_No" SortExpression="Capon_No" HeaderText="رقم الكابون" />
            <asp:BoundField DataField="Capon_Type"  SortExpression="Capon_Type" HeaderText="فئة الكابون" />
            <asp:BoundField DataField="Driver_Name" HeaderText="اسم السائق" 
                SortExpression="Driver_Name" />
            <asp:BoundField DataField="Car_Number" HeaderText="رقم القاطرة" 
                SortExpression="Car_Number" />
            <asp:BoundField DataField="Trailer_Number" HeaderText="رقم المقطورة" 
                SortExpression="Trailer_Number" />
            <asp:BoundField DataField="LeavingTime1" 
                HeaderText="تاريخ التحميل" SortExpression="LeavingTime1" DataFormatString="{0:dd/MM/yyyy}" />
            <asp:BoundField DataField="From_Name" HeaderText="من" 
                SortExpression="From_Name" />
            <asp:BoundField DataField="to_Name" HeaderText="الى" 
                SortExpression="to_Name" />
            
        </Columns>
        
        
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle HorizontalAlign="Center" BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#999999" />
        <AlternatingRowStyle BackColor="#cecece" ForeColor="#000000" />
    </asp:GridView>
    </td>
    </tr>
    <tr>
    
    <td>
    
    
    <table class="tr1" width="98%">
        <tr>
            <td>
                عدد الكابونات : <%=GridView1.Rows.Count %>
            </td>
            
            <td>
                مجموع الكابونات : <%=GetSum(2).ToString("###,###,###") %> لتر
            </td>
            
            
        </tr>
    </table>
    
    
    </td>
    
    </tr>
    </table>
</asp:Content>

