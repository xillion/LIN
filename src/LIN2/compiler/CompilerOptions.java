package LIN2.compiler;


import com.beust.jcommander.JCommander;
import com.beust.jcommander.Parameter;
import com.beust.jcommander.Parameters;

import java.util.ArrayList;
import java.util.List;

public class CompilerOptions {
    public class TargetOptions {
        @Parameter(description = "sources...", required = true)
        private List<String> sources = new ArrayList<>();

        @Parameter(names = {"-o","--output"}, description = "Output directory.", required = true)
        private String outputDirectory;

        public List<String> getSources() {
            return sources;
        }

        public String getOutputDirectory() {
            return outputDirectory;
        }
    }

    @Parameters(commandDescription = "Generate the slave C slave driver.")
    public class SlaveDriverOptions extends TargetOptions {
        @Parameter(names = {"-s","--slave"},description = "name of slave node to export")
        private String slaveName;

        public String getSlaveName() {
            return slaveName;
        }
    }
    private SlaveDriverOptions slaveDriverOptions = new SlaveDriverOptions();

    @Parameters(commandDescription = "Generate the slave C master driver.")
    public class MasterDriverOptions extends TargetOptions {
    }
    private MasterDriverOptions masterDriverOptions = new MasterDriverOptions();

    @Parameter(names = {"-h","--help"}, help = true, description = "Show help this message.")
    private boolean help = false;

    private JCommander jCommander;

    public CompilerOptions() {
        jCommander = new JCommander(this);
        jCommander.setProgramName("jLIN");
        jCommander.addCommand("slave",slaveDriverOptions);
        jCommander.addCommand("master",masterDriverOptions);
    }

    public void parse(String[] args) {
        jCommander.parse(args);
    }

    public boolean getHelp() {
        return help;
    }

    public SlaveDriverOptions getSlaveDriverOptions() {
        return jCommander.getParsedCommand().equals("slave") ? slaveDriverOptions : null;
    }

    public MasterDriverOptions getMasterDriverOptions() {
        return jCommander.getParsedCommand().equals("master") ? masterDriverOptions : null;
    }

    public void usage() {
        if(jCommander.getParsedCommand() != null)
            jCommander.usage(jCommander.getParsedCommand());
        else
            jCommander.usage();

    }
}