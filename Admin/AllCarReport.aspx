<%@ Page Title="تقرير حركات جميع رؤوس القاطرة و المقطورات" Language="C#" MasterPageFile="Reports.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            int CurentYear = DateTime.Now.Year;
            for (int i = 1; i <= 31; i++)
            {
                if (i <= 12)
                {
                    month1.Items.Add(new ListItem(i.ToString(), i.ToString()));
                    month2.Items.Add(new ListItem(i.ToString(), i.ToString()));
                }
                day1.Items.Add(new ListItem(i.ToString(), i.ToString()));
                day2.Items.Add(new ListItem(i.ToString(), i.ToString()));

            }
            for (int i = 2010; i <= CurentYear + 1; i++)
            {
                year1.Items.Add(new ListItem(i.ToString(), i.ToString()));
                year2.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }

            if (day2.Items.FindByValue(DateTime.Now.Day.ToString()) != null)
            {
                day2.Items.FindByValue(DateTime.Now.Day.ToString()).Selected = true;
            }

            if (month2.Items.FindByValue(DateTime.Now.Month.ToString()) != null)
            {
                month2.Items.FindByValue(DateTime.Now.Month.ToString()).Selected = true;
            }

            if (year2.Items.FindByValue(DateTime.Now.Year.ToString()) != null)
            {
                year2.Items.FindByValue(DateTime.Now.Year.ToString()).Selected = true;
            }
        }
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        DateTime d1=new DateTime(int.Parse(year1.SelectedValue),int.Parse(month1.SelectedValue),int.Parse(day1.SelectedValue));
        DateTime d2 = new DateTime(int.Parse(year2.SelectedValue), int.Parse(month2.SelectedValue), int.Parse(day2.SelectedValue));
        SqlDataSource1.SelectParameters["d1"].DefaultValue = d1.ToString();
        SqlDataSource1.SelectParameters["d2"].DefaultValue = d2.ToString();
        
        SqlDataSource1.DataBind();
        
        
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
            l.Text = (e.Row.RowIndex+1).ToString();

            l = (Label)e.Row.FindControl("capon330");
            l.Text = DataBase.Get330capon(l.Text);

            l = (Label)e.Row.FindControl("capon50");
            l.Text = DataBase.Get50capon(l.Text);
        }
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

    
</script>


<asp:Content ContentPlaceHolderID="Header" ID="c1" runat="server">
    <table width="100%">
        <tr>
            <td style="text-align:right;">
            <%=DateTime.Now.ToShortDateString() %>
            </td>
            <td style="text-align:left;">
                <%=DateTime.Now.ToShortTimeString() %>
            </td>
                
        </tr>
    </table>
    <table class="LogInTable" align="center">
        <tr>
            <td class="Title">
                تقرير حركات جميع رؤوس القاطرات و المقطورات
            </td>
        </tr>
        <tr>
            <td>
                <table>
                    <tr class="tr2">
                        <td>من تاريخ</td>
                        <td>
                            <asp:DropDownList ID="day1" runat="server">
                            </asp:DropDownList> - 
                            <asp:DropDownList ID="month1" runat="server">
                            </asp:DropDownList> - 
                            <asp:DropDownList ID="year1" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td>الى تاريخ</td>
                        <td>
                            <asp:DropDownList ID="day2" runat="server">
                            </asp:DropDownList> - 
                            <asp:DropDownList ID="month2" runat="server">
                            </asp:DropDownList> - 
                            <asp:DropDownList ID="year2" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td align="center">
                             <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">تنفيذ</asp:LinkButton> |  <a onclick="window.print();">طباعة</a>
                        </td> 
                        
                    </tr>
                    
                </table>
            </td>
        </tr>
        
    </table>
    
    
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Body" Runat="Server">
    
    
    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:CS %>" 
        SelectCommand="SELECT Transports.id, Drivers.Name AS Driver_Name, Transports.FromId, Transports.ToId, Cars.Number AS Car_Number,  Trailer.Number AS Trailer_Number,Transports.Tonnage,Transports.Tonnage2,Transports.Tonnage-Transports.Tonnage2 AS Difrent,Transports.LoadNo,Transports.EmptyingNo, Transports.ArrivalTime1, Transports.LeavingTime1 FROM Transports INNER JOIN Drivers ON Transports.DriverId = Drivers.id INNER JOIN Cars ON Transports.CarID = Cars.id INNER JOIN Trailer ON Transports.TrailerID = Trailer.id where (DATEDIFF(dd,LeavingTime1,@d1)<=0 and DATEDIFF(dd,LeavingTime1,@d2)>=0) Order By LeavingTime1">
        <SelectParameters>
            <asp:Parameter Name="d1"  />
            <asp:Parameter Name="d2"  />
            
        </SelectParameters>    
    </asp:SqlDataSource>
   
    <asp:GridView AllowSorting="true" ID="GridView1" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" 
        GridLines="None" Width="100%" HorizontalAlign="Right" OnRowDataBound="GridView1_RowDataBound">
        <RowStyle  BackColor="#F7F6F3" HorizontalAlign="Center" ForeColor="#333333" />
        <EmptyDataRowStyle CssClass="Title" HorizontalAlign="Center" />
        <EmptyDataTemplate>
            لا يوجد بيانات
        </EmptyDataTemplate>
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Label ID="no" runat="server" ></asp:Label>
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
                HeaderText="تاريخ التحميل" SortExpression="LeavingTime1" DataFormatString="{0:dd/MM/yyyy}" />
            <asp:BoundField DataField="ArrivalTime1" 
                HeaderText="تاريخ التفريغ" SortExpression="ArrivalTime1" DataFormatString="{0:dd/MM/yyyy}" />
                
            <asp:BoundField DataField="LoadNo" 
                HeaderText="رقم التحميل" SortExpression="LoadNo" /> 
            
            <asp:BoundField DataField="EmptyingNo" 
                HeaderText="رقم التفريغ" SortExpression="EmptyingNo" />
            
            <asp:BoundField DataField="Tonnage" 
                HeaderText="الحمولة" SortExpression="Tonnage" DataFormatString="{0:###,###,###}"  />  
             
           <asp:BoundField DataField="Tonnage2" 
                HeaderText="وزن التفريغ" SortExpression="Tonnage2" DataFormatString="{0:###,###,###}"  />   
                
           <asp:BoundField DataField="Difrent" 
                HeaderText="الفرق" SortExpression="Difrent" DataFormatString="{0:###,###,###}"  />   
                     
            <asp:TemplateField HeaderText="كوبون 330">
                <ItemTemplate>
                    <asp:Label ID="capon330" runat="server" Text='<%#Eval("id") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField> 
            
            
            <asp:TemplateField HeaderText="كوبون 50">
                <ItemTemplate>
                    <asp:Label ID="capon50" runat="server" Text='<%#Eval("id") %>'></asp:Label>
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
                مجموع الفروق : <%=GetSum(12).ToString("###,###,###")%>
            </td>
        </tr>
    </table>
    
</asp:Content>

