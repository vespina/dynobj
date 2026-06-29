# DynObj

This class is a little utility to create dynamic objects on the fly in VFP: just assign a value to a 
property and the property is automatically added to the object:

<vfp>
LOCAL oPerson
oPerson = CREATE("DynObj")
oPerson.firstName = "Victor"
oPerson.lastName = "Espina"
oPerson.Age = 55

?oPerson.firstName --> "Victor"
</vfp>

