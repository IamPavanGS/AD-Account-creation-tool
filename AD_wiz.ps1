Add-Type -AssemblyName PresentationFramework
[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="ADWiz" Height="425" Width="550" >
    <Grid Background="#ECEFF1">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="125"/>
            <ColumnDefinition Width="*"/>
        </Grid.ColumnDefinitions>
        

        <Label Content="First Name:" Grid.Row="0" Grid.Column="0" Margin="5"/>
        <TextBox x:Name="FirstNameTextBox" Grid.Row="0" Grid.Column="1" Margin="5"/>

        <Label Content="Last Name:" Grid.Row="1" Grid.Column="0" Margin="5"/>
        <TextBox x:Name="LastNameTextBox" Grid.Row="1" Grid.Column="1" Margin="5"/>

                <Label Content="DisplayName:" Grid.Row="2" Grid.Column="0" Margin="5"/>
               <TextBox x:Name="DisplayNameTextBox" Grid.Row="2" Grid.Column="1" Margin="5">
            <TextBox.Text>
                <MultiBinding StringFormat="{}{0} {1}">
                    <Binding Path="Text" ElementName="FirstNameTextBox" Mode="OneWay" UpdateSourceTrigger="PropertyChanged"/>
                    <Binding Path="Text" ElementName="LastNameTextBox" Mode="OneWay" UpdateSourceTrigger="PropertyChanged"/>
                </MultiBinding>
            </TextBox.Text>
        </TextBox>

        <Label Content="Username:" Grid.Row="3" Grid.Column="0" Margin="5"/>
        <TextBox x:Name="UsernameTextBox" Grid.Row="3" Grid.Column="1" Margin="5"/>

        <Label Content="Email:" Grid.Row="4" Grid.Column="0" Margin="5"/>
        <TextBox x:Name="EmailTextBox" Grid.Row="4" Grid.Column="1" Margin="5"/>

        <Label Content="Password:" Grid.Row="5" Grid.Column="0" Margin="5" Visibility="Visible"/>
        <PasswordBox x:Name="PasswordBox" Grid.Row="5" Grid.Column="1" Margin="5"/>
        <CheckBox x:Name="ChangePasswordCheckBox" Grid.Row="9" Grid.Column="1" Margin="5" Content="Change password at next logon"/>

        <Button x:Name="GeneratePasswordButton" Content="Random Passwd" Grid.Row="5" Grid.Column="0" Margin="5" Background="#B0BEC5"/>

        <Label Content="Job Title:" Grid.Row="6" Grid.Column="0" Margin="5"/>
        <TextBox x:Name="JobTitleTextBox" Grid.Row="6" Grid.Column="1" Margin="5"/>

         <Label Content="Reporting Manager:" Grid.Row="7" Grid.Column="0" Margin="5"/>
        <TextBox x:Name="ReportingManagerTextBox" Grid.Row="7" Grid.Column="1" Margin="5"/>

        <Label Content="Location:" Grid.Row="8" Grid.Column="0" Margin="5"/>
        <ComboBox x:Name="LocationComboBox" Grid.Row="8" Grid.Column="1" Margin="5">
            <ComboBoxItem Content="Bangalore"/>
            <ComboBoxItem Content="Hyderabad"/>
            <ComboBoxItem Content="Noida"/>
            <ComboBoxItem Content="Chennai"/>
            <ComboBoxItem Content="Romania"/>
            <ComboBoxItem Content="Israel"/>
            <ComboBoxItem Content="Madagascar"/>
            <ComboBoxItem Content="California"/>
            <ComboBoxItem Content="Canada"/>
            <ComboBoxItem Content="Germany"/>
            <ComboBoxItem Content="Mexico"/>
            <ComboBoxItem Content="UK"/>
            <ComboBoxItem Content="San Diego"/>
            <ComboBoxItem Content="Argentina"/>
        </ComboBox>
    
        <Button x:Name="CreateUserButton" Content="Create User" Grid.Row="9" Grid.Column="1" Margin="5" Background="#2196F3" Foreground="White" FontWeight="Bold" FontSize="16" Padding="10 5" HorizontalAlignment="Right" VerticalAlignment="Center"/>
        <TextBlock Text="Created by Pavan G S" Grid.Row="10" Grid.Column="1" Margin="5" HorizontalAlignment="Left" VerticalAlignment="Bottom"/>
        

    </Grid>
</Window>
"@

$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)

$UsernameTextBox = $window.FindName("UsernameTextBox")
$PasswordBox = $window.FindName("PasswordBox")
$FirstNameTextBox = $window.FindName("FirstNameTextBox")
$LastNameTextBox = $window.FindName("LastNameTextBox")
$EmailTextBox = $window.FindName("EmailTextBox")
$LocationComboBox = $window.FindName("LocationComboBox")
$CreateButton = $window.FindName("CreateUserButton")
$GeneratePasswordButton = $window.FindName("GeneratePasswordButton")
$ReportingManagerTextBox = $window.FindName("ReportingManagerTextBox")
$DisplayNameTextBox = $window.FindName("DisplayNameTextBox")
$JobTitleTextBox = $window.FindName("JobTitleTextBox")
$ChangePasswordCheckBox = $window.FindName("ChangePasswordCheckBox")



$GeneratePasswordButton.Add_Click({
$chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+[]{};:,.<>?`~"
$passwordLength = 14
$password = -join ($chars.ToCharArray() | Get-Random -Count $passwordLength)
$PasswordBox.Password = $password
# Copy the password to the clipboard
$password | Set-Clipboard
})

$CreateButton.Add_Click({
# Get user input from the form
$username = $UsernameTextBox.Text
$password = $PasswordBox.Password
$firstname = $FirstNameTextBox.Text
$lastname = $LastNameTextBox.Text
$email = $EmailTextBox.Text
$location = $LocationComboBox.Text
$displayname = $DisplayNameTextBox.Text
$manager = $ReportingManagerTextBox.Text
$jobtitle = $JobTitleTextBox.Text
$changePassword = $ChangePasswordCheckBox.IsChecked

if ($jobtitle -eq $null) {
        $jobtitle = "Unknown"
    }

    if ($manager -eq $null) {
        $manager = "None"
    }

# Set the country and OU based on the selected location
switch ($location) {
    "Bangalore" {
        $replaceParams = @{
        c = "IN"
        co = "India"
        countrycode = 356
        }
        $ou = ""
           $City = ""
           $zipcode = ""
           $Company = ""
           $State = ""
           $StreetAddress = ""
           $telephone = ""
        break
    }
    "UK" {
        $replaceParams = @{
        c = "GB"
        co = "United Kingdom"
        countrycode = 826
        }
        $ou = ""
           $City = ""
           $zipcode = ""
           $Company = ""
           $State = ""
           $StreetAddress = ""
           $telephone = ""
        break
    }
    "California" {
        $replaceParams = @{
        c = "US"
        co = "United States"
        countrycode = 840
        }
        $ou = ""
           $City = ""
           $zipcode = ""
           $Company = ""
           $State = ""
           $StreetAddress = ""
           $telephone = ""
        break
    }
     "Canada" {
        $replaceParams = @{
        c = "CA"
        co = "Canada"
        countrycode = 124
        }
        $ou = ""
        $City = ""
           $zipcode = ""
           $Company = ""
           $State = ""
           $StreetAddress = ""
           $telephone = ""
        break
    }
     "Chennai" {
        $replaceParams = @{
        c = "IN"
        co = "India"
        countrycode = 356
        }
        $ou = ""
        $City = ""
           $zipcode = ""
           $Company = ""
           $State = ""
           $StreetAddress = ""
           $telephone = ""
        break
    }
     "Germany" {
        $replaceParams = @{
        c = "DE"
        co = "Germany"
        countrycode = 276
        }
        $ou = ""
        $City = ""
           $zipcode = ""
           $Company = ""
           $State = ""
           $StreetAddress = ""
           $telephone = ""
        break
    }
     "Hyderabad" {
        $replaceParams = @{
        c = "IN"
        co = "India"
        countrycode = 356
        }
        $ou = ""
        $City = ""
           $zipcode = ""
           $Company = ""
           $State = ""
           $StreetAddress = ""
           $telephone = ""
        break
    }
     "Noida" {
        $replaceParams = @{
        c = "IN"
        co = "India"
        countrycode = 356
        }
        $ou = ""
        $City = ""
           $zipcode = ""
           $Company = ""
           $State = ""
           $StreetAddress = ""
           $telephone = ""
        break
    }
     "Israel" {
        $replaceParams = @{
        c = "IL"
        co = "Israel"
        countrycode = 376
        }
        $ou = ""
        $City = ""
           $zipcode = ""
           $Company = ""
           $State = ""
           $StreetAddress = ""
           $telephone = ""
        break
    }
     "Madagascar" {
        $replaceParams = @{
        c = "MG"
        co = "Madagascar"
        countrycode = 450
        }
        $ou = ""
        $City = ""
           $zipcode = ""
           $Company = ""
           $State = ""
           $StreetAddress = ""
           $telephone = " "
        break
    }
    "Mexico" {
        $replaceParams = @{
        c = "MX"
        co = "Mexico"
        countrycode = 484
        }
        $ou = ""
        $City = ""
           $zipcode = ""
           $Company = ""
           $State = ""
           $StreetAddress = ""
           $telephone = ""
        break
    }
    "Romania" {
        $replaceParams = @{
        c = "RO"
        co = "Romania"
        countrycode = 642
        }
        $ou = ""
        $City = ""
           $zipcode = ""
           $Company = ""
           $State = ""
           $StreetAddress = ""
           $telephone = ""
        break
    }
    "San Diego" {
        $replaceParams = @{
        c = "US"
        co = "United States"
        countrycode = 840
        }
        $ou = ""
        $City = ""
           $zipcode = ""
           $Company = ""
           $State = ""
           $StreetAddress = ""
           $telephone = ""
        break
    }
    "Argentina" {
        $replaceParams = @{
        c = "AR"
        co = "Argentina"
        countrycode = 32
        }
        $ou = ""
        $City = ""
           $zipcode = ""
           $Company = ""
           $State = ""
           $StreetAddress = ""
           $telephone = ""
        break
    }

}

try {
    # Check if the user already exists
    if (Get-ADUser -Filter {SamAccountName -eq $username}) {
        # Show a message box indicating that the user already exists
        [System.Windows.MessageBox]::Show("User $username already exists.")
        return
    }

    # Create the user in Active Directory
    #$newUser = New-ADUser -Name "$firstname $lastname" -SamAccountName $username -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -GivenName $firstname -Surname $lastname -EmailAddress $email -Enabled $true -Country $country -Path $ou

    New-ADUser -SamAccountName $username -Name "$firstname $lastname"  -GivenName $firstname -Surname $lastname -Initials $initials -Enabled $True -DisplayName $displayname -Path $OU -City $city -PostalCode $zipcode -Country $country -Company $company -State $state -StreetAddress $streetaddress -OfficePhone $telephone -EmailAddress $email -Title $jobtitle -Department $department -Office $company -Manager $manager -AccountPassword (ConvertTo-secureString $password -AsPlainText -Force) -ChangePasswordAtLogon $changePassword

    Set-ADUser -Identity $username -Replace $replaceParams -add @{ProxyAddresses= "SMTP:"+$email -split ","}
    Set-ADUser -UserPrincipalName $username@testdomain.com -Identity $username
    Add-ADGroupMember -Identity "Global_Radius_Group" -Members $username


function global:notNullOrEmpty([object]$obj) {
    return ($obj -ne $null -and $obj -ne '')
}

if (notNullOrEmpty $telephone) {

    Set-ADUser $username -Add @{telephonenumber=$telephone}
}


    

    # Show a message box to confirm the user was created
    [System.Windows.MessageBox]::Show("User $username created in $location OU")
}
catch {
    # Show a message box indicating that an error occurred
    [System.Windows.MessageBox]::Show("An error occurred while creating the user account. Error details: $_")
}


# Clear input boxes
$UsernameTextBox.Text = ""
$PasswordBox.Password = $null
$FirstNameTextBox.Text = ""
$LastNameTextBox.Text = ""
$EmailTextBox.Text = ""
$ReportingManagerTextBox.Text = ""
$JobTitleTextBox.Text = ""
$DisplayNameTextBox.Text = ""
$LocationComboBox.SelectedIndex = -1
$ChangePasswordCheckBox.IsChecked = $false
})

$window.ShowDialog()
