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
 * Driver which sets up and starts the 'RunningLog' Hadoop MapReduce job.
 * @author Andrew Jarombek
 * @since 4/6/2020
 */

public class RunningLogDriver extends Configured implements Tool {

    @Override
    public int run(String[] args) throws Exception {
        if (args.length < 2) {
            System.out.printf("Args: %d\n", args.length);
            System.out.printf("Usage: %s [generic options] <inputdir> <outputdir>\n", getClass().getSimpleName());
            return -1;
        }

        Job job = Job.getInstance(getConf());
        job.setJarByClass(RunningLogDriver.class);
        job.setJobName("Running Log");

        FileInputFormat.setInputPaths(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));

        job.setMapperClass(RunningLogMapper.class);
        job.setReducerClass(RunningLogReducer.class);

        job.setMapOutputKeyClass(Text.class);
        job.setMapOutputValueClass(IntWritable.class);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(IntWritable.class);

        boolean success = job.waitForCompletion(true);
        return success ? 0 : 1;
    }

    public static void main(String... args) throws Exception {
        System.out.println("Running Log Driver");

        int exitCode = ToolRunner.run(new Configuration(), new RunningLogDriver(), args);
        System.exit(exitCode);
    }
}
