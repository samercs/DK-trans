<%@ Page Title="وصول مركبة" Language="C#" MasterPageFile="~/DataEntry/MasterPage.master" %>

<script runat="server">

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label l = (Label)e.Row.FindControl("Label1");
            l.Text = DataBase.GetPName("Centers", "name","id", l.Text);
            l = (Label)e.Row.FindControl("Label2");
            l.Text = DataBase.GetPName("Centers", "name", "id", l.Text);
        }
    }

    protected void ImageButton1_Command(object sender, CommandEventArgs e)
    {
        Session["ParameterId"] = e.CommandArgument;
        Session["FildID"] = "ArrivalTime2";
        Session["FildID2"] = "UpdateUserId2";
        Session["FildID3"] = "UpdateTime2";
        Response.Redirect("EnterTime.aspx");
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["type"] == null)
        {
            Response.Redirect("../default.aspx");
        }
        
        if (! Session["type"].ToString().Equals("2"))
        {
            Message msg = new Message("لا يجوز لك الدخول الى هذة الصفحة", false, "Default.aspx", "Default.aspx");
            Session["MSG"] = msg;
            Response.Redirect("Message.aspx");
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:CS %>" 
        SelectCommand="SELECT Transports.id, Drivers.Name AS Driver_Name, Transports.FromId, Transports.ToId, Cars.Number AS Car_Number,  Trailer.Number AS Trailer_Number, Transports.ArrivalTime1, Transports.LeavingTime2, Transports.LeavingTime1, Transports.ArrivalTime2 FROM Transports INNER JOIN Drivers ON Transports.DriverId = Drivers.id INNER JOIN Cars ON Transports.CarID = Cars.id INNER JOIN Trailer ON Transports.TrailerID = Trailer.id where ((not (arrivaltime1 is null)) and (not (leavingtime2 is null)) and (arrivaltime2 is null))"></asp:SqlDataSource>
    
   
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" 
        GridLines="None" Width="98%" HorizontalAlign="Right" OnRowDataBound="GridView1_RowDataBound">
        <RowStyle BackColor="#F7F6F3" HorizontalAlign="Center" ForeColor="#333333" />
        <Columns>
            <asp:BoundField DataField="id" HeaderText="رقم الرحلة" InsertVisible="False" 
                ReadOnly="True" SortExpression="id" />
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
            
            <asp:BoundField DataField="LeavingTime1" DataFormatString="{0:t}" 
                HeaderText="وقت المغادرة" SortExpression="LeavingTime1" />
            
            <asp:BoundField DataField="ArrivalTime1" DataFormatString="{0:t}" 
                HeaderText="وقت الوصول" SortExpression="ArrivalTime1" />
            
            <asp:BoundField DataField="LeavingTime2" DataFormatString="{0:t}" 
                HeaderText="وقت المغادرة" SortExpression="LeavingTime2" />
            
            <asp:TemplateField HeaderText="استقبال الشاحنة" >
                <ItemTemplate>
                    <asp:ImageButton ImageUrl="~/Images/ArrowLeft.png" CommandArgument='<%#Eval("id") %>' CommandName="Arrival" ID="ImageButton1" runat="server" OnCommand="ImageButton1_Command" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle HorizontalAlign="Right" BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#999999" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    </asp:GridView>
</asp:Content>

