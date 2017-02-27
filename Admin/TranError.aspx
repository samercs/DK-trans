<%@ Page Language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label l = (Label)e.Row.FindControl("DriverId");
            l.Text = DataBase.GetPName("Drivers", "name", "id", l.Text);
            if (l.Text.Trim().Length == 0)
            {
                e.Row.BackColor = System.Drawing.Color.Red;
            }
            l = (Label)e.Row.FindControl("CarID");
            l.Text = DataBase.GetPName("Cars", "Number", "id", l.Text);
            if (l.Text.Trim().Length == 0)
            {
                e.Row.BackColor = System.Drawing.Color.Red;
            }
            l = (Label)e.Row.FindControl("TrailerID");
            l.Text = DataBase.GetPName("trailer", "number", "id", l.Text);
            if (l.Text.Trim().Length == 0)
            {
                e.Row.BackColor = System.Drawing.Color.Red;
            }

            if (e.Row.BackColor != System.Drawing.Color.Red)
            {
                e.Row.Visible = false;
            }
        }
        
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:CS %>" 
            SelectCommand="SELECT * FROM [Transports] ORDER BY [id]"></asp:SqlDataSource>
    </div>
    <asp:GridView Width="100%" ID="GridView1" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" DataKeyNames="id" DataSourceID="SqlDataSource1" 
        ForeColor="#333333" GridLines="None" OnRowDataBound="GridView1_RowDataBound">
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <Columns>
            <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" 
                ReadOnly="True" SortExpression="id" />
            <asp:TemplateField HeaderText="Driver">
                <ItemTemplate>
                    <asp:Label ID="DriverId" runat="server" Text='<%#Eval("DriverId") %>'></asp:Label> 
                </ItemTemplate>
            </asp:TemplateField>
            
            
            <asp:TemplateField HeaderText="car">
                <ItemTemplate>
                    <asp:Label ID="CarID" runat="server" Text='<%#Eval("CarID") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Trailer">
                <ItemTemplate>
                    <asp:Label ID="TrailerID" runat="server" Text='<%#Eval("TrailerID") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            
            
           
            <asp:BoundField DataField="LoadNo" HeaderText="LoadNo" 
                SortExpression="LoadNo" />
            <asp:BoundField DataField="EmptyingNo" HeaderText="EmptyingNo" 
                SortExpression="EmptyingNo" />
            <asp:BoundField DataField="LeavingTime1" HeaderText="LeavingTime1" 
                SortExpression="LeavingTime1" />
        </Columns>
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#999999" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    </asp:GridView>
    </form>
</body>
</html>
