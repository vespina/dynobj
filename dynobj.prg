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
	        CASE TYPE("THIS._Object") = "L" OR INLIST(pcPropName,"_object","tostring","getobject","clone") 
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
        LOCAL lcJSON
        lcJSON = JSON.Stringify(THIS._Object)	
        IF JSON.lastError.hasError
           THROW JSON.lastError.Message
           RETURN ""
        ENDIF
		RETURN lcJSON
		
	PROCEDURE getObject
		RETURN THIS._Object

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
ENDDEFINE
