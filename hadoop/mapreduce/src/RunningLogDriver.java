import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.util.Tool;

/**
 * Driver which sets up and starts the 'RunningLog' Hadoop MapReduce job.
 * @author Andrew Jarombek
 * @since 4/6/2020
 */

public class RunningLogDriver extends Configured implements Tool {

    @Override
    public int run(String[] args) throws Exception {
        return 0;
    }

    public static void main(String... args) {
        System.out.println("Running Log Driver");
    }
}
