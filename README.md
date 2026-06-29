# DynObj

This class is a little utility to create dynamic objects on the fly in VFP: just assign a value to a 
property and the property is automatically added to the object:


    LOCAL oPerson
    oPerson = CREATE("DynObj")
    oPerson.firstName = "Victor"
    oPerson.lastName = "Espina"
    oPerson.Age = 55

    ?oPerson.firstName --> "Victor"


You can also get a plain VFP object with all the properties using **getObject** method:

    LOCAL obj
    obj = oPerson.getObject()
    ?obj.age --> 55

If a JSON parser is present (like https://github/vespina/json) you can get a JSON representation of your object using the **ToString** method:

    LOCAL cJSON
    cJSON = oPerson.toString()
    ?cJSON --> {"fistName": "Victor", "lastName": "Espina", "age": 55}

Finally you can clone your object using the **clone** methohd:

    LOCAL oSibling
    oSibling = oPerson.clone()
    oSibling.firstName = "Ali"

    ?oSibling.firstName --> "Ali"
    ?oPerson.firstName --> "Victor"


    
