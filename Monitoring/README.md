# monitoring-scripts
List of monitoring scripts I use in Zabbix, JAMS, Shell, DPA, and other tools.

These are the scripts I usually use for monitoring Oracle databases purposes.

Many templates in the internet doesn't consider many items I am. I recommend you to see each one of them separate and make sure they make sense to you and your environment.

I have added a small summary in the scripts and this is how you can read:

-- -----------------------------------------------------------------------------------	
- Type: Alert | Display
-- -----------------------------------------------------------------------------------	

If the script starts with Alert word you can use to monitor the database. Otherwise it's just a display script you can user to show the information on Grafana for example, which can make the visualization much beter, but they have no monitoring value.

-- -----------------------------------------------------------------------------------	
- Execute per: Database | Instance
-- -----------------------------------------------------------------------------------	

All the scripts are using or the database views, or instance views, so in case you are running into a RAC environment, you don't need to have the Database ones in all nodes, only the instace ones.

-- -----------------------------------------------------------------------------------	
- Description: blablabla.............
-- -----------------------------------------------------------------------------------	

Just a small description of what the script does.

-- -----------------------------------------------------------------------------------	
- Datatype: NUMBER (Float)
-- -----------------------------------------------------------------------------------	

The datatype for you to configure your monitoring tool input.

-- -----------------------------------------------------------------------------------	
- Rules: blablabla.............
-- -----------------------------------------------------------------------------------	

If the script has any rule you need to configure or change.

-- -----------------------------------------------------------------------------------	
- Threshold: Depend on your environment
-- -----------------------------------------------------------------------------------	

This is the threshold I usually use in my clients to generate the alert. You may configure properly for your environment.

-- -----------------------------------------------------------------------------------	
- Frequency: Each ..... minutes
-- -----------------------------------------------------------------------------------	

The frequency I recommend to run the check through the monitoring. You may configure properly for your environment.
