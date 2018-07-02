** CRUD en Visual FoxPro (Create, Read, Update and Delete)

private oForm
oForm=newobject("Form1")
oForm.Show(1)
clear class Form1
return

define class Form1 as form
   AutoCenter = .t.
   Height = 300
   Width  = 500
   Caption= "Formulario CRUD"
   Name   = "Form1"
   Backcolor=rgb(230,230,230)
 
  add object lblBuscar as label with ;
    Caption = "Buscar:", ;
    Left    = 20, ;
    Top     = 20, ;
    Width   = 70, ;
    Height  = 20, ;
    Name    = "lblBuscar"
	Backcolor=rgb(230,230,230)

  add object txtBuscar as textbox with ;
    Left    = 70, ;
    Top     = 20, ;
    Width   =100, ;
    Height  = 25, ;
    Tabindex=  1, ;
	Format  = 'K',;
	Alignment= 2, ;
	Value   ='',;
    Name    = "txtBuscar"
  	

&& Add ListBox control
  add object lstData as clsListBox with ;
    Left    = 20, ;
    Top     = 50, ;
    Width   =200, ;
    Height  =170, ;
    Tabindex=  2, ;
    Name    = "lstData"
	

  add object lblName as label with ;
    Caption = "Nombre:", ;
    Left    =250, ;
    Top     =100, ;
    Width   = 70, ;
    Height  = 20, ;
    Name    = "lblName"
	Backcolor=rgb(230,230,230)

  add object lblSurname as label with ;
    Caption = "Apellido:", ;
    Left    =250, ;
    Top     =150, ;
    Width   = 70, ;
    Height  = 20, ;
    Name    = "lblSurname"
	Backcolor=rgb(230,230,230)

  add object txtName as textbox with ;
    Left    =310, ;
    Top     =100, ;
    Width   =150, ;
    Height  = 25, ;
    Tabindex=  3, ;
	Format  = '!K',;
	Value   ='',;
    Name    = "txtName"
  	
  add object txtSurname as textbox with ;
    Left    =310, ;
    Top     =150, ;
    Width   =150, ;
    Height  = 25, ;
    Tabindex=  4, ;
	Format  = '!K',;
	Value   ='',;
    Name    = "txtSurname"
  
  add object cmdCreate as commandbutton with ;
    Left    = 30, ;
    Top     =250, ;
    Width   =100, ;
    Height  = 30, ;
    Tabindex=  5, ;
    Caption = "Nuevo", ;
    Default = .T., ;
    Name    = "cmdCreate"
	
  add object cmdUpdate as commandbutton with ;
    Left    =180, ;
    Top     =250, ;
    Width   =100, ;
    Height  = 30, ;
    Tabindex=  6, ;
    Caption = "Actualizar", ;
    Default = .T., ;
    Name    = "cmdUpdate"
	
  add object cmdDelete as commandbutton with ;
    Left    =310, ;
    Top     =250, ;
    Width   =100, ;
    Height  = 30, ;
    Tabindex=  7, ;
    Caption = "Borrar", ;
    Default = .T., ;
    Name    = "cmdDelete"
	
	
 procedure txtName.Interactivechange 
   ThisForm.cmdCreate.Enabled = ( !empty(ThisForm.txtName.Value) and !empty(ThisForm.txtSurname.Value) )
 endproc
 
 procedure txtSurname.Interactivechange 
   ThisForm.cmdCreate.Enabled = ( !empty(ThisForm.txtName.Value) and !empty(ThisForm.txtSurname.Value) )
 endproc
 
 procedure cmdCreate.Click
    if !empty(ThisForm.txtName.Value) and !empty(ThisForm.txtSurname.Value) 
  	   ThisForm.lstData.AddItem ( alltrim(ThisForm.txtName.Value) + ', '+alltrim(ThisForm.txtSurname.Value) )
    endif
 endproc
 
 procedure cmdUpdate.Click
    if !empty(ThisForm.txtName.Value) and !empty(ThisForm.txtSurname.Value) 
   local nCnt 
   for nCnt = 1 to ThisForm.lstData.ListCount
      if ThisForm.lstData.Selected(nCnt)  && Is item selected?
		 
		 ThisForm.lstData.List(nCnt) = alltrim(ThisForm.txtName.Value)+', '+alltrim(ThisForm.txtSurname.Value)
		 
      endif
   endfor
    endif
 endproc
 
 procedure cmdDelete.Click
   local nCnt 
   for nCnt = 1 to ThisForm.lstData.ListCount
      if ThisForm.lstData.Selected(nCnt)  && Is item selected?
		 if MessageBox('¿Está seguro de borrar este elemento?',4+32+256,'--')=6 && Yes/No, Ask, 2nd; Yes
		    ThisForm.lstData.RemoveItem(nCnt)
		    ThisForm.txtName.Value    = ''
            ThisForm.txtSurname.Value = ''
         endif
      endif
   endfor
 endproc
 
enddefine

define class clsListBox as ListBox  && Create ListBox control
   Left= 10  && List Box column
   Top = 10  && List Box row
   
 procedure Click
   local nCnt 
   for nCnt = 1 to This.ListCount
      if This.Selected(nCnt)  && Is item selected?
         *!* ? space(5) + This.List(nCnt) && Show item
		 
		 ThisForm.txtName.Value    = alltrim(left  (This.List(nCnt),at(',',This.List(nCnt))-1))
         ThisForm.txtSurname.Value = alltrim(substr(This.List(nCnt),at(',',This.List(nCnt))+1))
		 
      endif
   endfor
   
enddefine

**