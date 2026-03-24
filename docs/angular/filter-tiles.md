---
title: CriteriaFilterTileComponent
---

# Class CriteriaFilterTileComponent

Criteria Filter Tile Component

## Example

```html
    <csdk-criteria-filter-tile
      [title]="criteriaFilterTileProps.title"
      [filter]="criteriaFilterTileProps.filter"
      (filterChange)="criteriaFilterTileProps.setFilter($event)"
    />
```
```ts
import { Component } from '@angular/core';
import { Filter, filterFactory } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-healthcare-model';

@Component({
  selector: 'app-filters',
  templateUrl: './filters.component.html',
  styleUrls: ['./filters.component.scss'],
})
export class FiltersComponent {
  DM = DM;
  title: 'Room Number',
  filter: filterFactory.lessThan(DM.Rooms.Room_number, 200) ,
  setFilter({ filter }: { filter: Filter | null }) {
    console.log(filter);
    if (filter) {
      this.filter = filter ;
    }
  },
}
```
<img src="../../../img/angular-criteria-filter-tile-example.png" width="225px" />

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

### constructor

> **new CriteriaFilterTileComponent**(`sisenseContextService`, `themeService`): [`CriteriaFilterTileComponent`](class.CriteriaFilterTileComponent.md)

Constructor for the `CriteriaFilterTileComponent`.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) | Sisense context service |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) | Theme service |

#### Returns

[`CriteriaFilterTileComponent`](class.CriteriaFilterTileComponent.md)

## Properties

### Constructor

#### sisenseContextService

> **sisenseContextService**: [`SisenseContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

### Other

#### arrangement

> **arrangement**: [`FilterVariant`](../type-aliases/type-alias.FilterVariant.md) \| `undefined`

Arrangement of the filter inputs. Use vertical for standard filter tiles and horizontal for toolbars

***

#### filter

> **filter**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)

Text or numeric filter object to initialize filter type and default values

***

#### filterChange

> **filterChange**: `EventEmitter`\< `ArgumentsAsObject`\< (`filter`) => `void`, [`"filter"`] \> \>

Callback returning updated filter object

***

#### measures

> **measures**: [`Measure`](../../sdk-data/interfaces/interface.Measure.md)[] \| `undefined`

List of available measures to rank by. Required only for ranking filters.

***

#### title

> **title**: `string`

Title for the filter tile, which is rendered into the header


---

---
title: DateRangeFilterTileComponent
---

# Class DateRangeFilterTileComponent

Date Range Filter Tile Component

## Example

```html
<csdk-date-range-filter-tile
      [title]="dateRangeFilterTileProps.title"
      [attribute]="dateRangeFilterTileProps.attribute"
      [filter]="dateRangeFilterTileProps.filter"
      (filterChange)="dateRangeFilterTileProps.setFilter($event)"
    />
```
```ts
import { Component } from '@angular/core';
import { Filter, filterFactory } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-healthcare-model';

@Component({
  selector: 'app-filters',
  templateUrl: './filters.component.html',
  styleUrls: ['./filters.component.scss'],
})
export class FiltersComponent {
  DM = DM;

  dateRangeFilterTileProps = {
    title: 'Range Filter',
    attribute: DM.ER.Date.Years,
    filter: filterFactory.dateRange(DM.ER.Date.Years),
    setFilter({ filter }: { filter: Filter | null }) {
      console.log(filter);
      if (filter) {
        this.filter = filter;
      }
    },
  };
}
```
<img src="../../../img/angular-date-range-filter-tile-example.png" width="450px" />

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

### constructor

> **new DateRangeFilterTileComponent**(`sisenseContextService`, `themeService`): [`DateRangeFilterTileComponent`](class.DateRangeFilterTileComponent.md)

Constructor for the `DateRangeFilterTileComponent`.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) | Sisense context service |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) | Theme service |

#### Returns

[`DateRangeFilterTileComponent`](class.DateRangeFilterTileComponent.md)

## Properties

### Constructor

#### sisenseContextService

> **sisenseContextService**: [`SisenseContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

### Other

#### attribute

> **attribute**: [`LevelAttribute`](../../sdk-data/interfaces/interface.LevelAttribute.md)

Date level attribute the filter is based on

***

#### dataSource

> **dataSource**: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

Data source the query is run against - e.g. `Sample ECommerce`

If not specified, the query will use the `defaultDataSource` specified in the parent Sisense Context.

***

#### earliestDate

> **earliestDate**: `string` \| `undefined`

Earliest allowed date for selection.

If not specified, the earliest date of the target date-level attribute will be used.

***

#### filter

> **filter**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)

Date range filter.

***

#### filterChange

> **filterChange**: `EventEmitter`\< `ArgumentsAsObject`\< (`filter`) => `void`, [`"filter"`] \> \>

Callback function that is called when the date range filter object should be updated.

***

#### lastDate

> **lastDate**: `string` \| `undefined`

Latest allowed date for selection.

If not specified, the latest date of the target date-level attribute will be used.

***

#### title

> **title**: `string`

Filter tile title


---

---
title: FilterTileComponent
---

# Class FilterTileComponent

UI component that renders a filter tile based on filter type

## Example

Here’s how to render a filter model as a filter tile.

```html
<!--Component HTML template in example.component.html-->
<csdk-filter-tile
 [filter]="filterTileProps.filter"
 (filterChange)="filterTileProps.filterChange($event)"
/>
```

```ts
// Component behavior in example.component.ts
import { Component } from '@angular/core';
import { type FilterTileProps } from '@sisense/sdk-ui-angular';
import { filterFactory } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-healthcare-model';

@Component({
 selector: 'example',
 templateUrl: './example.component.html',
 styleUrls: ['./example.component.scss'],
})
export class ExampleComponent {
 filterTileProps: FilterTileProps = {
   filter: filterFactory.members(DM.ER.Date.Years, ['2013-01-01T00:00:00']),
   filterChange({ filter }) {
     if (filter) {
       this.filter = filter;
     }
   },
 };
}
```
<img src="../../../img/angular-member-filter-tile-example.png" width="225px" />

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

### constructor

> **new FilterTileComponent**(`sisenseContextService`, `themeService`): [`FilterTileComponent`](class.FilterTileComponent.md)

Constructor for the `FilterTileComponent`.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) | Sisense context service |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) | Theme service |

#### Returns

[`FilterTileComponent`](class.FilterTileComponent.md)

## Properties

### Constructor

#### sisenseContextService

> **sisenseContextService**: [`SisenseContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

### Other

#### defaultDataSource

> **defaultDataSource**: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

Default data source used for filter tiles

***

#### filter

> **filter**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)

Filter to display

***

#### filterChange

> **filterChange**: `EventEmitter`\< [`FilterChangeEvent`](../type-aliases/type-alias.FilterChangeEvent.md) \>

Filter change event handler.

***

#### filterDelete

> **filterDelete**: `EventEmitter`\< `void` \>

Filter delete event handler.

***

#### filterEdit

> **filterEdit**: `EventEmitter`\< [`FilterEditEvent`](../type-aliases/type-alias.FilterEditEvent.md) \>

Filter edit event handler.


---

---
title: FiltersPanelComponent
---

# Class FiltersPanelComponent

Filters panel component that renders a list of filter tiles

## Example

Here's how to render a filters panel with a set of filters.

```html
<!--Component HTML template in example.component.html-->
<csdk-filters-panel
 [filters]="filtersPanelProps.filters"
 [defaultDataSource]="filtersPanelProps.defaultDataSource"
 (filtersChange)="filtersPanelProps.filtersChange($event)"
/>
```

```ts
// Component behavior in example.component.ts
import { Component } from '@angular/core';
import { type FiltersPanelProps } from '@sisense/sdk-ui-angular';
import { filterFactory } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-healthcare-model';

@Component({
 selector: 'example',
 templateUrl: './example.component.html',
 styleUrls: ['./example.component.scss'],
})
export class ExampleComponent {
 filtersPanelProps: FiltersPanelProps = {
   filters: [
     filterFactory.members(DM.ER.Date.Years, ['2013-01-01T00:00:00']),
     filterFactory.members(DM.ER.Departments.Department, ['Cardiology']),
   ],
   defaultDataSource: DM.DataSource,
   filtersChange({ filters }) {
     this.filtersPanelProps.filters = filters;
   },
 };
}
```

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

### constructor

> **new FiltersPanelComponent**(`sisenseContextService`, `themeService`): [`FiltersPanelComponent`](class.FiltersPanelComponent.md)

Constructor for the `FiltersPanelComponent`.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) | Sisense context service |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) | Theme service |

#### Returns

[`FiltersPanelComponent`](class.FiltersPanelComponent.md)

## Properties

### Constructor

#### sisenseContextService

> **sisenseContextService**: [`SisenseContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

### Other

#### config

> **config**: [`FiltersPanelConfig`](../interfaces/interface.FiltersPanelConfig.md) \| `undefined`

The configuration for the filters panel

***

#### defaultDataSource

> **defaultDataSource**: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

Default data source used for filter tiles

***

#### filters

> **filters**: [`FilterRelations`](../../sdk-data/interfaces/interface.FilterRelations.md) \| [`Filter`](../../sdk-data/interfaces/interface.Filter.md)[]

Array of filters to display

***

#### filtersChange

> **filtersChange**: `EventEmitter`\< [`FiltersPanelChangeEvent`](../type-aliases/type-alias.FiltersPanelChangeEvent.md) \>

Callback to handle changes in filters


---

---
title: MemberFilterTileComponent
---

# Class MemberFilterTileComponent

Member Filter Tile Component

## Example

```html
    <csdk-member-filter-tile
      title="Years Filter"
      [attribute]="DM.ER.Date.Years"
      [filter]="memberFilterTileProps.yearFilter"
      (filterChange)="memberFilterTileProps.setYearFilter($event)"
    />
```
```ts
import { Component } from '@angular/core';
import { Filter, filterFactory } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-healthcare-model';

@Component({
  selector: 'app-filters',
  templateUrl: './filters.component.html',
  styleUrls: ['./filters.component.scss'],
})
export class FiltersComponent {
  DM = DM;
  memberFilterTileProps = {
    yearFilter: filterFactory.members(DM.ER.Date.Years, ['2013-01-01T00:00:00']),
    setYearFilter({ filter }: { filter: Filter | null }) {
      if (filter) {
        this.yearFilter = filter;
      }
    },
  };
}
```
<img src="../../../img/angular-member-filter-tile-example.png" width="225px" />

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

### constructor

> **new MemberFilterTileComponent**(`sisenseContextService`, `themeService`): [`MemberFilterTileComponent`](class.MemberFilterTileComponent.md)

Constructor for the `MemberFilterTileComponent`.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) | Sisense context service |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) | Theme service |

#### Returns

[`MemberFilterTileComponent`](class.MemberFilterTileComponent.md)

## Properties

### Constructor

#### sisenseContextService

> **sisenseContextService**: [`SisenseContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

### Other

#### attribute

> **attribute**: [`Attribute`](../../sdk-data/interfaces/interface.Attribute.md)

Attribute to filter on. A query will run to fetch all this attribute's members

***

#### dataSource

> **dataSource**: [`DataSource`](../../sdk-data/type-aliases/type-alias.DataSource.md) \| `undefined`

Data source the query is run against - e.g. `Sample ECommerce`

If not specified, the query will use the `defaultDataSource` specified in the parent Sisense Context.

***

#### filter

> **filter**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md) \| `null`

Source filter object. Caller is responsible for keeping track of filter state

***

#### filterChange

> **filterChange**: `EventEmitter`\< `ArgumentsAsObject`\< (`filter`) => `void`, [`"filter"`] \> \>

Callback indicating when the source members filter should be updated

***

#### title

> **title**: `string`

Title for the filter tile, which is rendered into the header


---

---
title: RelativeDateFilterTileComponent
---

# Class RelativeDateFilterTileComponent

Relative Date Filter Tile Component

## Example

```html
<csdk-relative-date-filter-tile
      [title]="relativeDateFilterTileProps.title"
      [arrangement]="relativeDateFilterTileProps.arrangement"
      [filter]="relativeDateFilterTileProps.filter"
      (filterChange)="relativeDateFilterTileProps.setFilter($event)"
    />
```
```ts
import { Component } from '@angular/core';
import { Filter, filterFactory } from '@sisense/sdk-data';
import * as DM from '../../assets/sample-healthcare-model';

@Component({
  selector: 'app-filters',
  templateUrl: './filters.component.html',
  styleUrls: ['./filters.component.scss'],
})
export class FiltersComponent {
  DM = DM;

  relativeDateFilterTileProps = {
    title: 'Relative Date Filter',
    arrangement: 'vertical',
    filter: filterFactory.dateRelativeTo(DM.ER.Date.Days, 0, 150),
    setFilter({ filter }: { filter: Filter | null }) {
      console.log(filter);
      if (filter) {
        this.filter = filter;
      }
    },
  };
}
```
<img src="../../../img/angular-relative-date-filter-tile-example.png" width="225px" />

## Implements

- `AfterViewInit`
- `OnChanges`
- `OnDestroy`

## Constructors

### constructor

> **new RelativeDateFilterTileComponent**(`sisenseContextService`, `themeService`): [`RelativeDateFilterTileComponent`](class.RelativeDateFilterTileComponent.md)

Constructor for the `RelativeDateFilterTileComponent`.

#### Parameters

| Parameter | Type | Description |
| :------ | :------ | :------ |
| `sisenseContextService` | [`SisenseContextService`](../contexts/class.SisenseContextService.md) | Sisense context service |
| `themeService` | [`ThemeService`](../contexts/class.ThemeService.md) | Theme service |

#### Returns

[`RelativeDateFilterTileComponent`](class.RelativeDateFilterTileComponent.md)

## Properties

### Constructor

#### sisenseContextService

> **sisenseContextService**: [`SisenseContextService`](../contexts/class.SisenseContextService.md)

Sisense context service

***

#### themeService

> **themeService**: [`ThemeService`](../contexts/class.ThemeService.md)

Theme service

### Other

#### arrangement

> **arrangement**: [`FilterVariant`](../type-aliases/type-alias.FilterVariant.md) \| `undefined`

Arrangement of the filter inputs. Use vertical for standard filter tiles and horizontal for toolbars

***

#### filter

> **filter**: [`Filter`](../../sdk-data/interfaces/interface.Filter.md)

Relative date filter.

***

#### filterChange

> **filterChange**: `EventEmitter`\< `ArgumentsAsObject`\< (`filter`) => `void`, [`"filter"`] \> \>

Callback function that is called when the relative date filter object should be updated.

***

#### limit

> **limit**: \{
  `maxDate`: `string`;
  `minDate`: `string`;
 } \| `undefined`

Limit of the date range that can be selected.

***

#### title

> **title**: `string`

Filter tile title
