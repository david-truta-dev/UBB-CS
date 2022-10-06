package ro.msg.learning.shop.converter;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.MappingIterator;
import com.fasterxml.jackson.databind.ObjectWriter;
import com.fasterxml.jackson.dataformat.csv.CsvMapper;
import com.fasterxml.jackson.dataformat.csv.CsvSchema;
import lombok.Data;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

@Data
public
class ConverterUtil {

    public <T> List<T> fromCsv(Class<T> tClass, InputStream inputStream) throws IOException {
        CsvMapper mapper = new CsvMapper();
        mapper.enable(DeserializationFeature.ACCEPT_EMPTY_STRING_AS_NULL_OBJECT);
        CsvSchema schema = mapper.schemaFor(tClass);
        MappingIterator<T> it = mapper.readerFor(tClass).with(schema).readValues(inputStream);
        return it.readAll();
    }

    public <T> void toCsv(Class<?> tClass, List<T> tList, OutputStream outputStream) throws IOException {
        CsvMapper mapper = new CsvMapper();
        CsvSchema schema = mapper.schemaFor(tClass);
        ObjectWriter writer = mapper.writer(schema.withLineSeparator("\n"));
        writer.writeValue(outputStream, tList.toString());
        outputStream.close();
    }
}
