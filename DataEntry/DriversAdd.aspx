<%@ Page Title="اضافة سائق جديد" Language="C#" MasterPageFile="MasterPage.master" %>

<script runat="server">

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Page.Validate();
        if (Page.IsValid)
        {
            if (DataBase.Insert("Drivers", new string[] { "name", "phone" }, new string[] { TextBox1.Text, TextBox2.Text }))
            {
                Message msg = new Message("تم اضافة السائق", true, "Drivers.aspx", "Drivers.aspx");
                Session["MSG"] = msg;
                Response.Redirect("Message.aspx");
            }
            else
            {
                Message msg = new Message("خطا في النظام الرجاء المحاولة مرة اخرى", false, "Drivers.aspx", "Drivers.aspx");
                Session["MSG"] = msg;
                Response.Redirect("Message.aspx");
            }
        }
    }

    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (DataBase.GetPName("Drivers", "name", "name", TextBox1.Text).Trim().Length != 0)
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
                ادخال سائق جديد
            </td>
        </tr>
        <tr class="tr2">
            <td>
                اسم السائق 
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ErrorMessage="الرجاء ادخال اسم السائق" Text="*" ControlToValidate="TextBox1"></asp:RequiredFieldValidator>
                <asp:CustomValidator ID="CustomValidator1" ControlToValidate="TextBox1" Text="*" ErrorMessage="هذا السائق مدخل من قبل" runat="server" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
            </td>
            <td>
                <asp:TextBox ID="TextBox1" CssClass="Text" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr class="tr2">
            <td>
                رقم الهاتف 
                
            </td>
            <td>
                <asp:TextBox ID="TextBox2" CssClass="Text" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="2" class="Center">
                <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">اضافة</asp:LinkButton> | 
                <a href="Drivers.aspx">رجوع</a>
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

