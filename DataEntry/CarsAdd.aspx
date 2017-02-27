<%@ Page Title="اضافة قاطرة جديدة" Language="C#" MasterPageFile="MasterPage.master" %>

<script runat="server">

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Page.Validate();
        if (Page.IsValid)
        {
            if (DataBase.Insert("cars", new string[] { "Number", "Model", "Type", "Regesterdate", "Owner" }, new string[] { TextBox1.Text, TextBox2.Text, TextBox3.Text, TextBox4.Text, DropDownList1.SelectedValue }))
            {
                Message msg = new Message("تم اضافة القاطرة", true, "cars.aspx", "cars.aspx");
                Session["MSG"] = msg;
                Response.Redirect("Message.aspx");
            }
            else
            {
                Message msg = new Message("خطا في النظام الرجاء المحاولة مرة اخرى", false, "cars.aspx", "cars.aspx");
                Session["MSG"] = msg;
                Response.Redirect("Message.aspx");
            }
        }
    }

    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (DataBase.GetPName("Cars", "Number", "Number", TextBox1.Text).Trim().Length != 0)
        {
            args.IsValid = false;
        }
        else
        {

            args.IsValid = true;
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
    
<center>
    
    <table align="center" class="LogInTable">
        <tr>
            <td colspan="2" class="Title">
                ادخال قاطرة جديدة
            </td>
        </tr>
        <tr class="tr2">
            <td>
                رقم القاطرة
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ErrorMessage="الرجاء ادخال رقم القاطرة" Text="*" ControlToValidate="TextBox1"></asp:RequiredFieldValidator>
                <asp:CustomValidator ControlToValidate="TextBox1" Text="*" ID="CustomValidator1" runat="server" ErrorMessage="رقم القاطرة مدخل من قبل" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
            </td>
            <td>
                <asp:TextBox ID="TextBox1" CssClass="Text" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr class="tr2">
            <td>
                سنة الصنع
                
            </td>
            <td>
                <asp:TextBox ID="TextBox2" CssClass="Text" runat="server"></asp:TextBox>
            </td>
        </tr>
         <tr class="tr2">
            <td>
                نوع القاطرة
                
            </td>
            <td>
                <asp:TextBox ID="TextBox3" CssClass="Text" runat="server"></asp:TextBox>
            </td>
        </tr>
         <tr class="tr2">
            <td>
                تاريخ الترخيص
                
            </td>
            <td>
                <asp:TextBox ID="TextBox4" CssClass="Text" runat="server"></asp:TextBox>
            </td>
        </tr>
         <tr class="tr2">
            <td>
                المالك
                
            </td>
            <td>
                <asp:DropDownList ID="DropDownList1" runat="server" 
                    DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="ID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:CS %>" 
                    SelectCommand="SELECT [ID], [Name] FROM [Owners]"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td colspan="2" class="Center">
                <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">اضافة</asp:LinkButton> | 
                <a href="Cars.aspx">رجوع</a>
                <br />
                <br />
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
            </td>
        </tr>
    </table>
    
</center>

    </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>

