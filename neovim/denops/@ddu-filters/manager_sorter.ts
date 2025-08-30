import { BaseFilter } from "jsr:@shougo/ddu-vim@~6.1.0/filter";
import type { DduItem, SourceOptions } from "jsr:@shougo/ddu-vim@~6.1.0/types";
import type { Denops } from "jsr:@denops/core@~7.0.0";

type Params = {
  reverse?: boolean;
};

export class Filter extends BaseFilter<Params> {
  // 並び替えるfilterやで。
  override async filter(args: {
    denops: Denops;
    sourceOptions: SourceOptions;
    filterParams: Params;
    input: string;
    items: DduItem[];
  }): Promise<DduItem[]> {
    // idで昇順ソート。reverse指定で降順もできるで。
    const sorted = args.items.slice().sort((a, b) =>
      a.word > b.word ? 1 : -1
    );
    return args.filterParams.reverse ? sorted.reverse() : sorted;
  }
  override params(): Params {
    return { reverse: false };
  }
}
// コメント：sorterはこんな感じでitemの配列並び替えるだけや

