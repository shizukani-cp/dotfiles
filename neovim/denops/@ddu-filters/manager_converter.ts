import { BaseFilter } from "jsr:@shougo/ddu-vim@~6.1.0/filter";
import type { DduItem, SourceOptions } from "jsr:@shougo/ddu-vim@~6.1.0/types";
import type { Denops } from "jsr:@denops/core@~7.0.0";

type Params = {};

export class Filter extends BaseFilter<Params> {
  // converter でアイテムの表示を揃える処理
  override async filter(args: {
    denops: Denops;
    sourceOptions: SourceOptions;
    filterParams: Params;
    input: string;
    items: DduItem[];
  }): Promise<DduItem[]> {
    // statusの最大長を計算
    const maxStatusLen = Math.max(
      ...args.items.map((item) => (item.status?.length ?? 0))
    );

    for (const item of args.items) {
      // const status = (item.status as string) ?? "";
      // // 表示用にstatus欄を揃える
      // const paddedStatus = status + " ".repeat(maxStatusLen - status.length);
      // // wordは変えずにdisplayだけ整形して揃える
      // item.display = `${item.word} [${paddedStatus}]`;
      item.display = item.display
    }
    return args.items;
  }

  override params(): Params {
    return {};
  }
}

