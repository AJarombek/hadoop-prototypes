import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;

/**
 * Driver which sets up and starts the 'Pushups' Hadoop MapReduce job.
 * @author Andrew Jarombek
 * @since 4/11/2020
 */

public class PushupsDriver extends Configured implements Tool {

    @Override
    public int run(String[] args) throws Exception {
        if (args.length < 2) {
            System.out.printf("Usage: %s [generic options] <inputdir> <outputdir>\n", getClass().getSimpleName());
            return -1;
        }

        Job job = Job.getInstance(getConf());
        job.setJarByClass(PushupsDriver.class);
        job.setJobName("Pushups");

        FileInputFormat.setInputPaths(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));

        job.setMapperClass(PushupsMapper.class);
        job.setReducerClass(PushupsReducer.class);
        job.setPartitionerClass(PushupsPartitioner.class);

        job.setMapOutputKeyClass(IntWritable.class);
        job.setMapOutputValueClass(Text.class);
        job.setOutputKeyClass(IntWritable.class);
        job.setOutputValueClass(IntWritable.class);

        boolean success = job.waitForCompletion(true);
        return success ? 0 : 1;
    }

    public static void main(String... args) throws Exception {
        System.out.println("Pushups Driver");

        int exitCode = ToolRunner.run(new Configuration(), new PushupsDriver(), args);
        System.exit(exitCode);
    }
}
