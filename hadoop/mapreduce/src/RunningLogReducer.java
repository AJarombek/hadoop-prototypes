import org.apache.hadoop.io.FloatWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

import java.io.IOException;

public class RunningLogReducer extends Reducer<Text, FloatWritable, Text, FloatWritable> {

    private FloatWritable sumWritable = new FloatWritable();

    public void reduce(Text key, Iterable<FloatWritable> values, Context context)
            throws IOException, InterruptedException {

        float sum = 0;

        for (FloatWritable value : values) {
            sum += value.get();
        }

        sumWritable.set(sum);
        context.write(key, sumWritable);
    }
}
