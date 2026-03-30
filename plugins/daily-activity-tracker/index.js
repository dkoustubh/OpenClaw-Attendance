import { definePluginEntry } from "openclaw/plugin-sdk/plugin-entry";
import { Type } from "@sinclair/typebox";
import fs from "node:fs/promises";
import path from "node:path";
import os from "node:os";

const ACTIVITY_FILE = path.join(os.homedir(), ".openclaw", "workspace", "daily_activities.json");

async function loadActivities() {
    try {
        const data = await fs.readFile(ACTIVITY_FILE, "utf-8");
        return JSON.parse(data);
    } catch (e) {
        return [];
    }
}

async function saveActivities(activities) {
    await fs.mkdir(path.dirname(ACTIVITY_FILE), { recursive: true });
    await fs.writeFile(ACTIVITY_FILE, JSON.stringify(activities, null, 2), "utf-8");
}

export default definePluginEntry({
  id: "daily-activity-tracker",
  name: "Daily Activity Tracker",
  description: "A tool to track your daily activities and tasks.",
  register(api) {
    api.registerTool({
      name: "log_activity",
      description: "Log a completed daily activity. Useful for tracking routines.",
      parameters: Type.Object({ activity: Type.String() }),
      async execute(_id, params) {
        const activities = await loadActivities();
        const date = new Date().toISOString();
        activities.push({ date, activity: params.activity });
        await saveActivities(activities);
        return { content: [{ type: "text", text: `Activity "${params.activity}" logged successfully.` }] };
      },
    });

    api.registerTool({
      name: "get_activities",
      description: "Retrieve activities logged for today or historically.",
      parameters: Type.Object({ days: Type.Optional(Type.Number({ description: "Number of days to look back. Defaults to 1 for today." })) }),
      async execute(_id, params) {
        const activities = await loadActivities();
        const lookback = params.days || 1;
        const now = Date.now();
        const cutoff = now - (lookback * 24 * 60 * 60 * 1000);
        
        const recent = activities.filter((a) => new Date(a.date).getTime() > cutoff);
        if (recent.length === 0) {
            return { content: [{ type: "text", text: "No activities logged in the specified period." }] };
        }
        
        const report = recent.map((a) => `- [${new Date(a.date).toLocaleString()}] ${a.activity}`).join("\n");
        return { content: [{ type: "text", text: `Activities:\n${report}` }] };
      },
    });
  },
});
