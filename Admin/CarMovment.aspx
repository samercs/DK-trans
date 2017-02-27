<%@ Page Title="حركة الشاحنات" Language="C#" MasterPageFile="~/Admin/MasterPage.master" %>

<script runat="server">
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label l = (Label)e.Row.FindControl("Label1");
            l.Text = DataBase.GetPName("Centers", "name", "id", l.Text);
            l = (Label)e.Row.FindControl("Label2");
            l.Text = DataBase.GetPName("Centers", "name", "id", l.Text);
            l = (Label)e.Row.FindControl("no");
            l.Text = (int.Parse(l.Text)-32).ToString() ;
        }
    }

    protected void Timer1_Tick(object sender, EventArgs e)
    {
        SqlDataSource1.DataBind();
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    
    <ContentTemplate>
    
            <div class="Center">
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:CS %>" 
                    SelectCommand="SELECT Transports.id, Drivers.Name AS Driver_Name, Transports.FromId, Transports.ToId, Cars.Number AS Car_Number,  Trailer.Number AS Trailer_Number,Transports.Tonnage,Transports.LoadNo, Transports.ArrivalTime1, Transports.LeavingTime1 FROM Transports INNER JOIN Drivers ON Transports.DriverId = Drivers.id INNER JOIN Cars ON Transports.CarID = Cars.id INNER JOIN Trailer ON Transports.TrailerID = Trailer.id where (arrivaltime1 is null)"></asp:SqlDataSource>
                
             <div class="Title">  تاريخ اخر تحديث <%=DateTime.Now.ToString() %></div>
             <br />
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" 
                    GridLines="None" Width="98%" HorizontalAlign="Right" 
                        OnRowDataBound="GridView1_RowDataBound" AllowPaging="false" AllowSorting="True" 
                        PageSize="20">
                    <RowStyle BackColor="#F7F6F3" HorizontalAlign="Center" ForeColor="#333333" />
                    <Columns>
                        
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Label ID="no" runat="server" Text='<%#Eval("id") %>'></asp:Label>
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
                            HeaderText="تاريخ التحميل" SortExpression="LeavingTime1" />
                        <asp:BoundField DataField="Tonnage" 
                            HeaderText="الحمولة" SortExpression="Tonnage" />  
                         <asp:BoundField DataField="LoadNo" 
                            HeaderText="رقم التحميل" SortExpression="LoadNo" /> 
                                 
                        
                    </Columns>
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <HeaderStyle HorizontalAlign="Right" BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <EditRowStyle BackColor="#999999" />
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                </asp:GridView>
                </div>
     <asp:Timer ID="Timer1" runat="server" OnTick="Timer1_Tick">
    </asp:Timer>
    </ContentTemplate>
    
    
    </asp:UpdatePanel>
   
    
</asp:Content>

