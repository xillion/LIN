package com.ptransportation.LIN.compiler.generation.models;


import com.ptransportation.LIN.models.PolymorphismModelAdaptor;
import com.ptransportation.capability.nodeCapabilityFile.Frame;
import com.ptransportation.capability.nodeCapabilityFile.Node;
import org.stringtemplate.v4.ST;
import org.stringtemplate.v4.misc.STNoSuchPropertyException;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class FrameModelAdaptor extends PolymorphismModelAdaptor {
    static final List<String> INTEGER_FIELDS = Arrays.asList("length", "minPeriod","maxPeriod");

    @Override
    public synchronized Object getProperty(ST self, Object o, Object property, String propertyName) throws STNoSuchPropertyException {
        Frame frame = (Frame)o;
        if(propertyName.equals("useClassicChecksum")) {
            double version = Double.parseDouble(
                    ((Node)frame.eContainer()).getProtocolVersion().replaceAll("\"",""));
            return version < 2.0;
        }
        else if(INTEGER_FIELDS.contains(propertyName)) {
            String str = (String)super.getProperty(self, o, property, propertyName);
            if(str != null)
                return Integer.decode(str);
            return null;
        }

        return super.getProperty(self, o, property, propertyName);
    }
}
