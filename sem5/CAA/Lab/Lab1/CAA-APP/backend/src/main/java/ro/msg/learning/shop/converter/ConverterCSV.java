package ro.msg.learning.shop.converter;

import org.springframework.http.HttpInputMessage;
import org.springframework.http.HttpOutputMessage;
import org.springframework.http.MediaType;
import org.springframework.http.converter.AbstractGenericHttpMessageConverter;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.lang.reflect.Type;
import java.util.Collections;
import java.util.List;

@Component
public class ConverterCSV extends AbstractGenericHttpMessageConverter {

    private ConverterUtil converterUtil = new ConverterUtil();

    public ConverterCSV() {
        super(new MediaType("text", "csv"));
    }

    @Override
    protected void writeInternal(Object o, Type type, HttpOutputMessage httpOutputMessage) throws  IOException {

        List<Object> objectArrayList = Collections.singletonList(o);
        converterUtil.toCsv(o.getClass(), objectArrayList, httpOutputMessage.getBody());
    }

    @Override
    protected Object readInternal(Class aClass, HttpInputMessage httpInputMessage) throws IOException {
        return converterUtil.fromCsv(aClass, httpInputMessage.getBody());
    }

    @Override
    public Object read(Type type, Class aClass, HttpInputMessage httpInputMessage) throws IOException {
        return readInternal(aClass, httpInputMessage);
    }
}
