<%@ Page Title="تقرير المالكين" Language="C#" MasterPageFile="Reports.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            SqlDataSource1.SelectParameters["d1"].DefaultValue = Session["d1"].ToString();
            SqlDataSource1.SelectParameters["d2"].DefaultValue = Session["d2"].ToString();
            SqlDataSource1.SelectParameters["fromid"].DefaultValue = Session["from"].ToString();
            SqlDataSource1.SelectParameters["toid"].DefaultValue = Session["to"].ToString();
            SqlDataSource1.SelectParameters["owner"].DefaultValue = Session["owner"].ToString();
            SqlDataSource1.DataBind();
            GridView1.DataBind();
            
        }
    }

   


    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label l = (Label)e.Row.FindControl("Label1");
            l.Text = DataBase.GetPName("Centers", "name", "id", l.Text);
            l = (Label)e.Row.FindControl("Label2");
            l.Text = DataBase.GetPName("Centers", "name", "id", l.Text);
            l = (Label)e.Row.FindControl("no");
            l.Text = (e.Row.RowIndex + 1).ToString();

            HiddenField h1 = (HiddenField)e.Row.FindControl("tmp1");
            HiddenField h2 = (HiddenField)e.Row.FindControl("tmp2");
            l = (Label)e.Row.FindControl("r");
            double d1 = 0, d2 = 0;
            double.TryParse(h1.Value, out d1);
            double.TryParse(h2.Value, out d2);

            l.Text = Math.Min(d1, d2).ToString("###,###,###");
        }
    }

    

    private double GetSum(int Index)
    {
        double result = 0;
        double tmp;
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            if (double.TryParse(GridView1.Rows[i].Cells[Index].Text,out tmp))
            {
                result += tmp;
            }
            
        }
        return result;
    }


    private double GetSum(int Index, string cname)
    {
        double result = 0;
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
        return result;
    }
</script>

<asp:Content ContentPlaceHolderID="Header" ID="C1" runat="server">
    <table  width="100%">
        <tr style="font-size:10px;">
            <td style="text-align:right;">
            <%=DateTime.Now.ToShortDateString() %>
            </td>
            <td style="text-align:left;">
                <%=DateTime.Now.ToShortTimeString() %>
            </td>
                
        </tr>
    </table>
    <table style="font-size:12px;color:Black;" align="center">
        <tr>
            <td>
                مؤسسة ابو حسين الذيابات للنقل
                <br />
                تقرير حركات سيارات المالكين
            </td>
        </tr>
        <tr>
            <td>
                اسم الشركة <%=DataBase.GetPName("Owners","name","id",Session["owner"].ToString()) %>
            </td>
        </tr>
        <tr>
            <td>
                الفترة من <%=DateTime.Parse (Session["d1"].ToString()).ToString("dd/MM/yyyy") %> الى <%=DateTime.Parse(Session["d2"].ToString()).ToString("dd/MM/yyyy") %>
            </td>
        </tr>
         <tr>
            <td>
                منطقة التحميل <%=DataBase.GetPName("Centers","name","id",Session["from"].ToString()) %> منطقة التفريغ <%=DataBase.GetPName("Centers","name","id",Session["to"].ToString()) %>
            </td>
        </tr>
        
        
        
    </table>
</asp:Content>


<asp:Content ID="Content1" ContentPlaceHolderID="Body" Runat="Server">
    
    
    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:CS %>" 
        SelectCommand="SELECT Transports.id, Drivers.Name AS Driver_Name, Transports.FromId, Transports.ToId, Cars.Number AS Car_Number,  Trailer.Number AS Trailer_Number,Transports.Tonnage,Transports.Tonnage2,Transports.Tonnage-Transports.Tonnage2 AS Difrent,Transports.LoadNo,Transports.EmptyingNo, Transports.ArrivalTime1, Transports.LeavingTime1 FROM Transports INNER JOIN Drivers ON Transports.DriverId = Drivers.id INNER JOIN Cars ON Transports.CarID = Cars.id INNER JOIN Trailer ON Transports.TrailerID = Trailer.id where Transports.fromid=@fromid and Transports.toid=@toid and (DATEDIFF(dd,LeavingTime1,@d1)<=0 and DATEDIFF(dd,LeavingTime1,@d2)>=0 and (transports.trailerid in (select id from trailer where owner=@owner)))">
        <SelectParameters>
            <asp:Parameter Name="d1"  />
            <asp:Parameter Name="d2"  />
            <asp:Parameter Name="owner" />
            <asp:Parameter Name="fromid" />
            <asp:Parameter Name="toid" />
        </SelectParameters>    
    </asp:SqlDataSource>
    
    <table width="100%">
        <tr>
            <td>
            
   
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" 
        GridLines="Both" Width="100%" HorizontalAlign="Right" OnRowDataBound="GridView1_RowDataBound">
        <RowStyle  BackColor="#F7F6F3" HorizontalAlign="Center" ForeColor="#333333" />
        <EmptyDataRowStyle HorizontalAlign="Center" CssClass="Title" />
        <EmptyDataTemplate>
            لا يوجد بيانات
        </EmptyDataTemplate>
        <Columns>
            
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Label ID="no" runat="server" Text=""></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="من" SortExpression="FromId">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%#Eval("FromId") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="الى" SortExpression="ToId">
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%#Eval("ToId") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Driver_Name" HeaderText="اسم السائق" 
                SortExpression="Driver_Name" />
            <asp:BoundField DataField="Car_Number" HeaderText="رقم القاطرة" 
                SortExpression="Car_Number" />
            <asp:BoundField DataField="Trailer_Number" HeaderText="رقم المقطورة" 
                SortExpression="Trailer_Number" />
            <asp:BoundField DataField="LeavingTime1" 
                HeaderText="تاريخ التحميل" DataFormatString="{0:dd/MM/yyyy}" SortExpression="LeavingTime1" />
            
            <asp:BoundField DataField="ArrivalTime1" 
                HeaderText="تاريخ التفريغ" DataFormatString="{0:dd/MM/yyyy}" SortExpression="ArrivalTime1" />
                
            <asp:BoundField DataField="LoadNo" 
                HeaderText="رقم التحميل" SortExpression="LoadNo" /> 
            
            <asp:BoundField DataField="EmptyingNo" 
                HeaderText="رقم التفريغ" SortExpression="EmptyingNo" />
            
            <asp:BoundField DataFormatString="{0:###,###,###}" DataField="Tonnage" 
                HeaderText="الحمولة" SortExpression="Tonnage" />  
             
           <asp:BoundField DataFormatString="{0:###,###,###}" DataField="Tonnage2" 
                HeaderText="وزن التفريغ" SortExpression="Tonnage2" />   
                
            <asp:TemplateField HeaderText="الوزن المصروف">
                <ItemTemplate>
                    <asp:HiddenField ID="tmp1" Value='<%#Eval("Tonnage") %>' runat="server" />
                    <asp:HiddenField ID="tmp2" Value='<%#Eval("Tonnage2") %>' runat="server" />
                    <asp:Label ID="r" runat="server" ></asp:Label>
                </ItemTemplate>
           </asp:TemplateField>     
                     
            
        </Columns>
        
        
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle HorizontalAlign="Center" BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#999999" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    </asp:GridView>
    </td>
        </tr>
    <tr>
        <td>
        
        
    
    <table class="tr1" width="98%">
        <tr>
            <td>
                عدد النقلات : <%=GridView1.Rows.Count %>
            </td>
            
            <td>
                مجموع اوزان التحميل : <%=GetSum(10).ToString("###,###,###") %>
            </td>
            
            <td>
                مجموع اوزان التفريغ : <%=GetSum(11).ToString("###,###,###")%>
            </td>
            <td>
                مجموع الوزن المصروف : <%=GetSum(12,"r").ToString("###,###,###")%>
            </td>
        </tr>
    </table>
    
    
    </td>
    </tr>
    </table>
    
</asp:Content>

