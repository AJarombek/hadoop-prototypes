import org.apache.hadoop.io.FloatWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

import java.io.IOException;
import java.util.Iterator;

public class RunningLogReducer extends Reducer<Text, FloatWritable, Text, FloatWritable> {

    public void reducer(Text key, Iterator<FloatWritable> values, Context context) throws IOException {

    }
}
