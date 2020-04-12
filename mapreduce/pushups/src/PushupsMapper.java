import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

import java.io.IOException;

/**
 * Mapper which executes map() tasks in the 'Pushups' Hadoop MapReduce job.
 * @author Andrew Jarombek
 * @since 4/11/2020
 */

public class PushupsMapper extends Mapper<LongWritable, Text, IntWritable, Text> {

    private Text date = new Text();
    private IntWritable pushups = new IntWritable();

    @Override
    public void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
        String line = value.toString();
        String[] columnVals = line.split(",");

        date.set(columnVals[1]);
        pushups.set(Integer.valueOf(columnVals[2]));

        context.write(pushups, date);
    }
}
