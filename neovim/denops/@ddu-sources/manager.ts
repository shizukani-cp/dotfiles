import {
  type DduOptions,
  type Item,
  type SourceOptions,
} from "jsr:@shougo/ddu-vim@~6.1.0/types";
import { BaseSource } from "jsr:@shougo/ddu-vim@~6.1.0/source";
import { type ActionData } from "jsr:@shougo/ddu-kind-file@~0.9.0";
import type { Denops } from "jsr:@denops/core@~7.0.0";

type Params = Record<never, never>;
type PluginStatus = { status: "new" | "installing" | "installed" | "loaded" };

export class Source extends BaseSource<Params> {
  // override kind = "manager";

  override gather(args: {
    denops: Denops;
    options: DduOptions;
    sourceOptions: SourceOptions;
    sourceParams: Params;
    input: string;
  }): ReadableStream<Item<ActionData>[]> {
    return new ReadableStream({
      async start(controller) {
        const tree = async (plugins: Record<string, PluginStatus>) => {
          const items: Item<ActionData>[] = [];
          try {
            const maxIdLen = Math.max(...Object.keys(plugins).map(id => id.length));
            const maxStatusLen = Math.max(...Object.values(plugins).map(p => p.status.length));

            for (const id of Object.keys(plugins)) {
              const status = plugins[id].status;
              // plugin名を右にパディング
              const paddedId = id + " ".repeat(maxIdLen - id.length);
              // statusは右側にスペースで揃える
              const paddedStatus = status + " ".repeat(maxStatusLen - status.length);

              items.push({
                word: `${paddedId} ${paddedStatus}`,
                display: `${paddedId} ${paddedStatus}`,  // []なしで表示
                action: {
                  load_id: id,
                },
              });
            }
          } catch (e: unknown) {
            console.error(e);
          }
          return items;
        };

        controller.enqueue(
          await tree(
            await args.denops.eval(
              `luaeval('require("utils.manager").plugins')`
            )
          ),
        );
        controller.close();
      },
    });
  }

  override params(): Params {
    return {};
  }
}

