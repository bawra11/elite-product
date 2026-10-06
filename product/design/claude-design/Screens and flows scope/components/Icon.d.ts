import * as React from 'react';
export type IconName =
  | "ArrowUpRight"
  | "AttachFile"
  | "SwapHoriz";
export interface IconProps extends React.SVGProps<SVGSVGElement> {
  name: IconName;
  size?: number | string;
}
export declare const Icon: React.FC<IconProps>;
export default Icon;
