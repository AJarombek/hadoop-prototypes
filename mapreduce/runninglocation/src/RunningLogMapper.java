import org.apache.hadoop.io.FloatWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

import java.io.IOException;

/**
 * Mapper which executes map() tasks in the 'RunningLog' Hadoop MapReduce job.
 * @author Andrew Jarombek
 * @since 4/8/2020
 */

public class RunningLogMapper extends Mapper<LongWritable, Text, Text, FloatWritable> {

    private Text location = new Text();
    private FloatWritable miles = new FloatWritable();

    @Override
    public void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
        String line = value.toString();
        String[] columnVals = line.split(",");

        location.set(columnVals[2]);
        miles.set(Float.valueOf(columnVals[4]));

        context.write(location, miles);
    }
}
