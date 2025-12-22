import {
  type DduOptions,
  type Item,
  type SourceOptions,
} from "jsr:@shougo/ddu-vim@~6.1.0/types";
import { BaseSource } from "jsr:@shougo/ddu-vim@~6.1.0/source";
import type { Denops } from "jsr:@denops/core@~7.0.0";

type Params = Record<never, never>;

type LogEntry = {
  level: number;
  msg: string;
  time: number;
};

type ActionData = LogEntry;

function formatTime(timestampRaw: number | bigint): string {
  const timestampSec = Number(timestampRaw);
  const d = new Date(timestampSec * 1000);

  if (isNaN(d.getTime())) return "Invalid Date";

  const pad = (n: number) => n.toString().padStart(2, "0");
  const year = d.getFullYear();
  const month = pad(d.getMonth() + 1);
  const day = pad(d.getDate());
  const hours = pad(d.getHours());
  const minutes = pad(d.getMinutes());
  const seconds = pad(d.getSeconds());

  return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
}

export class Source extends BaseSource<Params> {
  override kind = "word";

  override gather(args: {
    denops: Denops;
    options: DduOptions;
    sourceOptions: SourceOptions;
    sourceParams: Params;
    input: string;
  }): ReadableStream<Item<ActionData>[]> {
    return new ReadableStream({
      async start(controller) {
        try {
          const logs = await args.denops.call(
            "luaeval",
            `require("manager.core").logger:get_logs(1)`
          ) as LogEntry[];

          const items: Item<ActionData>[] = [];

          const levelMap: Record<number, string> = {
            0: "TRACE",
            1: "DEBUG",
            2: "INFO",
            3: "WARN",
            4: "ERROR",
            5: "OFF",
          };

          for (const log of logs) {
            const levelNum = Number(log.level);
            const levelName = levelMap[levelNum] ?? "UNKNOWN";
            const timeStr = formatTime(log.time);

            const displayText = `${timeStr} [${levelName}] ${log.msg}`;

            items.push({
              word: displayText,
              display: displayText,
              action: {
                ...log,
                level: levelNum,
                time: Number(log.time),
              },
            });
          }

          controller.enqueue(items);
        } catch (e: unknown) {
          console.error(`[ddu-source-manager-log] Error: ${String(e)}`);
        }
        controller.close();
      },
    });
  }

  override params(): Params {
    return {};
  }
}
