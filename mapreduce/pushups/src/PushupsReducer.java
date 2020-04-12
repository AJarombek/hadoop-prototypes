import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

import java.io.IOException;

/**
 * Reducer which executes reduce() tasks in the 'Pushups' Hadoop MapReduce job.
 * @author Andrew Jarombek
 * @since 4/11/2020
 */

public class PushupsReducer extends Reducer<IntWritable, Text, IntWritable, IntWritable> {

    private IntWritable daysWritable = new IntWritable();

    public void reduce(IntWritable key, Iterable<Text> values, Context context)
            throws IOException, InterruptedException {

        int days = 0;

        for (Text value : values) {
            days++;
        }

        daysWritable.set(days);
        context.write(key, daysWritable);
    }
}
