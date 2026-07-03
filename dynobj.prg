* DYNOBJ.PRG
* Dynamic properties object
*
DEFINE CLASS dynobj AS Custom

	PROTECTED _object
	
	PROCEDURE Init
		THIS._object = CREATEOBJECT("EMPTY")
		RETURN
		
	PROCEDURE THIS_Assign(pcPropName, puPropValue)
		STORE puPropValue TO ("THIS._object." + pcPropName)
		RETURN
		
	PROCEDURE THIS_Access(pcPropName)
	    pcPropName = LOWER(pcPropName)
	    DO CASE 	    			    
	        CASE TYPE("THIS._Object") = "L" OR INLIST(pcPropName,"_object","tostring","getobject","clone","_flat") 
	    		RETURN THIS
	    			
	    	OTHERWISE
	    		IF NOT PEMSTATUS(THIS._object, pcPropName, 5)
					ADDPROPERTY(THIS._object, pcPropName, NULL)
				ENDIF
			    RETURN THIS._Object
		ENDCASE

	PROCEDURE ToString
	    IF TYPE("JSON.Name") <> "C"
            THROW "No existe el objeto JSON"
	    	RETURN ""
	    ENDIF
        LOCAL lcJSON,loJSON
        loJSON = THIS.getObject()
        lcJSON = JSON.Stringify(loJSON)
        IF JSON.lastError.hasError
           THROW JSON.lastError.Message
           RETURN ""
        ENDIF
		RETURN lcJSON
		
		
	PROCEDURE getObject
	    LOCAL oCopy,aPropCount,nProp,cProp,uValue
	    LOCAL ARRAY aProps[1]
	    oCopy = CREATEOBJECT("Empty")
	    nPropCount = AMEMBERS(aProps, THIS._object, 0)
	    FOR nProp = 1 TO nPropCount
	        cProp = aProps[nProp]
	        uValue = THIS._flat( GETPEM(THIS._Object, cProp) )
	        ADDPROPERTY(oCopy, cProp, uValue)
	    ENDFOR	
		RETURN oCopy
		

	PROCEDURE Clone(plGetObject)
		LOCAL oClon,cProp,nProp,nProps
		LOCAL ARRAY aProps[1]
		oClon = CREATEOBJECT("DynObj")
		nProps = AMEMBERS(aProps, THIS._Object, 0)
		FOR nProp = 1 TO nProps
			cProp = aProps[nProp]
			STORE GETPEM(THIS._Object, cProp) TO ("oClon." + cProp)
		ENDFOR
		RETURN IIF(plGetObject,oClon.getObject(),oClon)
		
	HIDDEN FUNCTION _flat(puValue)
		LOCAL oFlat
		DO CASE 
		   CASE VARTYPE(puValue) <> "O"
			    oFlat = puValue
		
	       CASE PEMSTATUS(puValue, "count", 5)
		    	LOCAL oItem, uValue
		    	oFlat = CREATEOBJECT("Collection")
		    	FOR EACH oItem IN puValue FOXOBJECT
		    	    uValue = THIS._flat(oItem)
		    		oFlat.Add(uValue)
		    	ENDFOR
		    	
	       CASE PEMSTATUS(puValue, "getObject", 5)
	        	oFlat = puValue.getObject()
	    
	       OTHERWISE
	            oFlat = puValue
	    ENDCASE
	    RETURN oFlat

ENDDEFINE
