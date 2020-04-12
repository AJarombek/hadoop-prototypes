import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Partitioner;

/**
 * Partitioner that decides which reducer runs the reduce() task for a given data set
 * in the 'Pushups' Hadoop MapReduce job.
 * @author Andrew Jarombek
 * @since 4/12/2020
 */

public class PushupsPartitioner extends Partitioner<IntWritable, Text> {

    @Override
    public int getPartition(IntWritable key, Text value, int numPartitions) {
        String date = value.toString();

        if (date.compareTo("2020-04-01") < 0) {
            // March
            return 0;
        } else {
            // April
            return 1;
        }
    }
}
